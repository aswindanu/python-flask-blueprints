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
from app import cache


class ParentResource(Resource):
    def __init__(self, db=db, cache=cache, model=None, form=None, enable_translate:bool=False):
        self.db = db
        self.cache = cache
        self.model = model
        self.form = form
        self.enable_translate = enable_translate
        self.bypass_login = False
        self.is_login = cache.get("is_login")
        self.user_id = cache.get("user_id")
        self.profile_code = cache.get("profile_code")

    def check_permission(self, context={}):
        if self.profile_code == "ADMIN":
            return True
        if self.is_login:
            return True
        return False

    # API
    def get_data(self, args: dict, enable_translate=False, content_type='application/json'):
        if not self.bypass_login:
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
        if not self.bypass_login:
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
        if not self.bypass_login:
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
        if not self.bypass_login:
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
        if not self.bypass_login:
            self.check_permission()
        if enable_translate:
            result = translate(result)
        if code == 204 or not content_type:
            return (result, code)
        if code != 200:
            return result, code, {'Content-Type': content_type}
        return {"status":"success", "result": result}, code, {'Content-Type': content_type}

    # TEMPLATE
    def success_template(self, html_doc, results={}, redirect_url=False, redirect_modules=False, query_param={}, form=None, context={}):
        if not self.bypass_login:
            self.check_permission()
        headers = {'Content-Type': 'text/html'}
        if redirect_modules:
            res = make_response(redirect(url_for(html_doc, **query_param)))
        elif redirect_url:
            res = make_response(redirect(html_doc))
        else:
            form = form or self.form
            res = make_response(render_template(html_doc, form=form, results=results, title="Weight"), 200, headers)
            # if form.validate():
            #     res = make_response(render_template(html_doc, form=form or self.form, results=results, title="Weight"), 200, headers)
            # else:
            #     self.error_template()
        if context.get("access_token"):
            set_access_cookies(res, context.get("access_token"))
        if context.get("refresh_token"):
            set_refresh_cookies(res, context.get("refresh_token"))
        if context.get("reset_token"):
            for key, value in request.cookies.items():
                res.set_cookie(key, "", expires=0)
        if context.get("cookies", []):
            for k, v in context.get("cookies", []):
                res.set_cookie(k, v)
        return res

    def error_template(self, html_doc='error.html', results={}, message="Bad request", status_code=400):
        if not self.bypass_login:
            self.check_permission()
        headers = {'Content-Type': 'text/html'}
        res = make_response(render_template(html_doc, results=results, message=message, title="Weight"), status_code, headers)
        return res