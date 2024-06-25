import re

from flask import (
    render_template, 
    make_response, 
    request,
    redirect, 
    url_for
)
from flask_restful import Resource, marshal
from flask_jwt_extended import (
    jwt_required,
    get_jwt_identity, get_jwt,
    set_access_cookies,
    set_refresh_cookies,
    verify_jwt_in_request
)
from sqlalchemy import desc
from sqlalchemy.exc import IntegrityError
from psycopg2.errors import UniqueViolation

from internal.util.translate import translate
from infrastructure.model.db_model import db


class ParentResource(Resource):
    def __init__(self, db=db, model=None, is_login:bool=False, profile_code:str=None, enable_translate:bool=False):
        self.db = db
        self.model = model
        self.enable_translate = enable_translate
        self.is_login = is_login
        self.profile_code = profile_code
        self.access_token = request.cookies.get('access_token')
        self.refresh_token = request.cookies.get('refresh_token')

    @jwt_required()
    def check_permission(self, context={}):
        verify_jwt_in_request()
        claims = get_jwt()
        self.is_login = True
        self.profile_code = claims["profile_id"]
        if self.profile_code == "ADMIN":
            return True
        if self.is_login:
            return True
        return False

    def get_data(self, args: dict, enable_translate=False, content_type='application/json'):
        self.check_permission()
        enable_translate = enable_translate or self.enable_translate
        if args["id"]:
            qrys = self.model.query.get(args["id"])
            if qrys:
                qrys = [qrys]
        else:
            qrys = self.model.query.order_by(desc(self.model.id))
        if not qrys:
            return self.response({'status':'failed',"result":"ID Not Found"}, 404, enable_translate=enable_translate, content_type=content_type)
        result = [marshal(qry, self.model.response_field) for qry in qrys]
        return self.response(result, enable_translate=enable_translate, content_type=content_type)

    def create_data(self, args: dict, enable_translate=False, content_type='application/json'):
        self.check_permission()
        enable_translate = enable_translate or self.enable_translate
        req = self.model(**args)
        try:
            db.session.add(req)
            db.session.commit()
        except IntegrityError as err:
            result = "Data already exists"
            reg = re.search(r"Key \((.*?)\)\=\((.*?)\)", str(err), re.IGNORECASE)
            if reg:
                result += f" ({reg.group(1)}={reg.group(2)})."
            return self.response({'status':'failed',"result": result}, 500, enable_translate=enable_translate, content_type=content_type)
        except Exception as err:
            return self.response({'status':'failed',"result":f"Internal Server Error : {err}"}, 500, enable_translate=enable_translate, content_type=content_type)
        return self.response("", 201, enable_translate=enable_translate, content_type=content_type)

    def update_data(self, id, args: dict, enable_translate=False, content_type='application/json'):
        self.check_permission()
        enable_translate = enable_translate or self.enable_translate
        qry = self.model.query.get(id)
        if not qry:
            return self.response({'status':'failed',"result":"ID Not Found"}, 404, enable_translate=enable_translate, content_type=content_type)
        try:
            qry.update(args)
            db.session.commit()
        except IntegrityError as err:
            result = "Data already exists"
            reg = re.search(r"Key \((.*?)\)\=\((.*?)\)", str(err), re.IGNORECASE)
            if reg:
                result += f" ({reg.group(1)}={reg.group(2)})."
            return self.response({'status':'failed',"result": result}, 500, enable_translate=enable_translate, content_type=content_type)
        except Exception as err:
            return self.response({'status':'failed',"result":f"Internal Server Error : {err}"}, 500, enable_translate=enable_translate, content_type=content_type)
        return self.response(marshal(qry, self.model.response_field), enable_translate=enable_translate, content_type=content_type)

    def delete_data(self, id: int, enable_translate=False, content_type=None):
        self.check_permission()
        enable_translate = enable_translate or self.enable_translate
        if not id:
            return self.response({'status':'failed',"result":"ID Not Found"}, 404, enable_translate=enable_translate, content_type=content_type)
        qry = self.model.query.get(id)
        if not qry:
            return self.response({'status':'failed',"result":"ID Not Found"}, 404, enable_translate=enable_translate, content_type=content_type)
        try:
            db.session.delete(qry)
            db.session.commit()
        except Exception as err:
            return self.response({'status':'failed',"result":f"Internal Server Error : {err}"}, 500, enable_translate=enable_translate, content_type=content_type)
        return self.response("", 204, enable_translate=enable_translate, content_type=content_type)

    def response(self, result, code=200, enable_translate=False, content_type='application/json'):
        if enable_translate:
            result = translate(result)
        if code == 204 or not content_type:
            return (result, code)
        if code != 200:
            return result, code, {'Content-Type': content_type}
        return {"status":"success", "result": result}, code, {'Content-Type': content_type}

    def success_template(self, html_doc, results={}, is_redirect=False, context={}):
        headers = {'Content-Type': 'text/html'}
        if not context.get("bypass_login"):
            if not self.check_permission():
                return self.error_template('error.html', [], 'Login Required %s' % self.access_token, 400)
        if is_redirect:
            res = make_response(redirect(url_for(html_doc)))
        else:
            res = make_response(render_template(html_doc, results=results, title="Weight"), 200, headers)
        if context.get("cookies", []):
            for cookie in context.get("cookies", []):
                if cookie["key"] == "access_token":
                    set_access_cookies(res, cookie["value"])
                elif cookie["key"] == "refresh_token":
                    set_refresh_cookies(res, cookie["value"])
                else:
                    res.set_cookie(cookie["key"], cookie["value"])
        return res

    def error_template(self, html_doc, results={}, message="Bad request", status_code=400):
        headers = {'Content-Type': 'text/html'}
        return make_response(render_template(html_doc, results=results, message=message, title="Weight"), status_code, headers)