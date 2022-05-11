# -*- coding: utf-8 -*-
import hashlib
from datetime import date, datetime
from unittest import result

from flask import Blueprint, redirect
from flask_restful import Resource, Api, reqparse, marshal, inputs, request
from flask_jwt_extended import jwt_required
from sqlalchemy import desc

from app import db, app
from model.db_model import User
from util.common import success_template, error_template


bp_user = Blueprint('user', __name__)
api = Api(bp_user)


class UserResource(Resource):
    @jwt_required()
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', location='args')
        args = parser.parse_args()

        if args["id"]:
            qry = User.query.get(args["id"])
            result = marshal(qry, User.response_field)
        else:
            qrys = User.query.order_by(desc(User.id))
            result = [marshal(qry, User.response_field) for qry in qrys]
        if result:
            return {"status":"success", "result":result}, 200, {'Content-Type':'application/json'}
        return {'status':'failed',"result":"ID Not Found"}, 404, {'Content-Type':'application/json'}

    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('email', location='json', required=True)
        parser.add_argument('username', location='json', required=True)
        parser.add_argument('password', location='json', required=True)
        parser.add_argument('fullname', location='json', required=True)
        parser.add_argument('phone', location='json', required=True)
        parser.add_argument('gender', location='json', required=True)
        args = parser.parse_args()

        req = User(**args, active=True, ip_address=request.remote_addr)
        try:
            db.session.add(req)
            db.session.commit()
        except Exception as err:
            return {'status':'failed',"result":f"Internal Server Error : {err}"}, 500, {'Content-Type':'application/json'}
        return ('', 201)

    @jwt_required()
    def put(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', location='args', required=True)
        parser.add_argument('email', location='json')
        parser.add_argument('username', location='json')
        parser.add_argument('password', location='json')
        parser.add_argument('fullname', location='json')
        parser.add_argument('phone', location='json')
        parser.add_argument('gender', location='json')
        args = parser.parse_args()

        if not args["id"]:
            return {'status':'failed',"result":"ID Not Found"}, 404, {'Content-Type':'application/json'}

        qry = User.query.get(args["id"])
        try:
            qry.email = args["email"]
            qry.username = args["username"]
            qry.password = args["password"]
            qry.fullname = args["fullname"]
            qry.phone = args["phone"]
            qry.gender = args["gender"]
            qry.ip_address = request.remote_addr
            db.session.commit()
        except Exception as err:
            return {'status':'failed',"result":f"Internal Server Error : {err}"}, 500, {'Content-Type':'application/json'}
        return {"status":"success", "result":marshal(qry, User.response_field)}, 200, {'Content-Type':'application/json'}

    @jwt_required()
    def delete(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', location='json', required=True)
        args = parser.parse_args()

        if not args["id"]:
            return {'status':'failed',"result":"ID Not Found"}, 404, {'Content-Type':'application/json'}

        qry = User.query.get(args["id"])

        if not qry:
            return {"status":"failed", "result":"ID Not Found"}, 404, {"Content-Type":"application/json"}

        try:
            db.session.delete(qry)
            db.session.commit()
        except Exception as err:
            return {'status':'failed',"result":f"Internal Server Error : {err}"}, 500, {'Content-Type':'application/json'}
        return ('', 204)

    def options(self):
        return {}, 200


api.add_resource(UserResource, '/user', '/user')
