import re

from flask_restful import Resource, marshal
from sqlalchemy import desc
from sqlalchemy.exc import IntegrityError
from psycopg2.errors import UniqueViolation

from infrastructure.model.db_model import db
from src.common.common import response

class ParentResource(Resource):
    def __init__(self, db=db, model=None, enable_translate=False):
        self.db = db
        self.model = model
        self.enable_translate = enable_translate

    def get_data(self, args: dict, enable_translate=False, content_type='application/json'):
        enable_translate = enable_translate or self.enable_translate
        if args["id"]:
            qrys = self.model.query.get(args["id"])
            if qrys:
                qrys = [qrys]
        else:
            qrys = self.model.query.order_by(desc(self.model.id))
        if not qrys:
            return response({'status':'failed',"result":"ID Not Found"}, 404, enable_translate=enable_translate, content_type=content_type)
        result = [marshal(qry, self.model.response_field) for qry in qrys]
        return response(result, enable_translate=enable_translate, content_type=content_type)

    def create_data(self, args: dict, enable_translate=False, content_type='application/json'):
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
            return response({'status':'failed',"result": result}, 500, enable_translate=enable_translate, content_type=content_type)
        except Exception as err:
            return response({'status':'failed',"result":f"Internal Server Error : {err}"}, 500, enable_translate=enable_translate, content_type=content_type)
        return response("", 201, enable_translate=enable_translate, content_type=content_type)

    def update_data(self, id, args: dict, enable_translate=False, content_type='application/json'):
        enable_translate = enable_translate or self.enable_translate
        qry = self.model.query.get(id)
        if not qry:
            return response({'status':'failed',"result":"ID Not Found"}, 404, enable_translate=enable_translate, content_type=content_type)
        try:
            qry.update(args)
            db.session.commit()
        except IntegrityError as err:
            result = "Data already exists"
            reg = re.search(r"Key \((.*?)\)\=\((.*?)\)", str(err), re.IGNORECASE)
            if reg:
                result += f" ({reg.group(1)}={reg.group(2)})."
            return response({'status':'failed',"result": result}, 500, enable_translate=enable_translate, content_type=content_type)
        except Exception as err:
            return response({'status':'failed',"result":f"Internal Server Error : {err}"}, 500, enable_translate=enable_translate, content_type=content_type)
        return response(marshal(qry, self.model.response_field), enable_translate=enable_translate, content_type=content_type)

    def delete_data(self, id: int, enable_translate=False, content_type='application/json'):
        enable_translate = enable_translate or self.enable_translate
        if not id:
            return response({'status':'failed',"result":"ID Not Found"}, 404, enable_translate=enable_translate, content_type=content_type)
        qry = self.model.query.get(id)
        if not qry:
            return response({'status':'failed',"result":"ID Not Found"}, 404, enable_translate=enable_translate, content_type=content_type)
        try:
            db.session.delete(qry)
            db.session.commit()
        except Exception as err:
            return response({'status':'failed',"result":f"Internal Server Error : {err}"}, 500, enable_translate=enable_translate, content_type=content_type)
        return response("", 204, enable_translate=enable_translate, content_type=content_type)
