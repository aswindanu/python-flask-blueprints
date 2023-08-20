from flask_restful import Resource, marshal
from sqlalchemy import desc

from infrastructure.model.db_model import db
from src.common.common import response

class ParentResource(Resource):
    def __init__(self, db=db, model=None):
        self.db = db
        self.model = model

    def get_data(self, args: dict):
        if args["id"]:
            qry = self.model.query.get(args["id"])
            result = marshal(qry, self.model.response_field)
        else:
            qrys = self.model.query.order_by(desc(self.model.id))
            result = [marshal(qry, self.model.response_field) for qry in qrys]
        if not result:
            return response({'status':'failed',"result":"ID Not Found"}, 404)
        return response(result)

    def create_data(self, args: dict):
        req = self.model(**args)
        try:
            db.session.add(req)
            db.session.commit()
        except Exception as err:
            return response({'status':'failed',"result":f"Internal Server Error : {err}"}, 500)
        return response("", 201)

    def update_data(self, id, args: dict):
        qry = self.model.query.get(id)
        if not qry:
            return response({'status':'failed',"result":"ID Not Found"}, 404)
        try:
            qry.update(args)
            db.session.commit()
        except Exception as err:
            return response({'status':'failed',"result":f"Internal Server Error : {err}"}, 500)
        return response(marshal(qry, self.model.response_field))

    def delete_data(self, id: int):
        if not id:
            return response({'status':'failed',"result":"ID Not Found"}, 404)
        qry = self.model.query.get(id)
        if not qry:
            return response({'status':'failed',"result":"ID Not Found"}, 404)
        try:
            db.session.delete(qry)
            db.session.commit()
        except Exception as err:
            return response({'status':'failed',"result":f"Internal Server Error : {err}"}, 500)
        return response("", 204)
