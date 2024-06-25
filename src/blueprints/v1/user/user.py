# -*- coding: utf-8 -*-
import hashlib
from datetime import date, datetime
from unittest import result

from flask import Blueprint, redirect
from flask_restful import Resource, Api, reqparse, marshal, inputs, request
from flask_jwt_extended import jwt_required
from sqlalchemy import desc

from infrastructure.model.db_model import User
from internal.util.auth import token_gen, get_username
from internal.util.encrypt import hash_password
from internal.service.crud import ParentResource


bp_user = Blueprint('user', __name__)
api = Api(bp_user)


class UserResource(ParentResource):
    def __init__(self):
        super().__init__(model=User)

    @jwt_required()
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', location='args')
        args = parser.parse_args()

        return super().get_data(args)

    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('language_id', location='json', required=True)
        parser.add_argument('email', location='json', required=True)
        parser.add_argument('username', location='json', required=True)
        parser.add_argument('password', location='json', required=True)
        parser.add_argument('fullname', location='json', required=True)
        parser.add_argument('phone', location='json', required=True)
        parser.add_argument('gender', location='json', required=True)
        args = parser.parse_args()

        args["password"] = hash_password(args["password"])
        args["active"] = True
        args["ip_address"] = request.remote_addr

        return super().create_data(args)

    @jwt_required()
    def put(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', location='args', required=True)
        parser.add_argument('language_id', location='json', required=True)
        parser.add_argument('email', location='json', required=True)
        parser.add_argument('username', location='json', required=True)
        parser.add_argument('fullname', location='json', required=True)
        parser.add_argument('phone', location='json', required=True)
        parser.add_argument('gender', location='json', required=True)
        args = parser.parse_args()

        if not args["id"]:
            return self.response({'status':'failed',"result":"ID Not Found"}, 404)
        qry = User.query.get(args["id"])
        if not qry:
            return self.response({'status':'failed',"result":"ID Not Found"}, 404)
        args["ip_address"] = request.remote_addr

        return super().update_data(qry.id, args)

    @jwt_required()
    def delete(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', location='args', required=True)
        args = parser.parse_args()

        return super().delete_data(args["id"])

    def options(self):
        return {}, 200


api.add_resource(UserResource, '/api/v1/user', '/api/v1/user')
