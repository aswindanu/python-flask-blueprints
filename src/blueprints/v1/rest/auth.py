import json, hashlib

from flask import Blueprint
from flask_restful import Api, Resource, reqparse, marshal
from flask_jwt_extended import (
    jwt_required,
    get_jwt_identity, get_jwt
)

from infrastructure.model.db_model import User
from internal.util.auth import token_gen
from internal.util.encrypt import validate_password


bp_auth = Blueprint('auth', __name__)
api = Api(bp_auth)


class LoginResource(Resource):
    @jwt_required()
    def get(self):
        """get profile"""
        claims = get_jwt()
        return {"status":"success", 'result': claims}, 200, {'Content-Type':'application/json'}

    def post(self):
        """login"""
        parser = reqparse.RequestParser()
        parser.add_argument('email_or_username', location='json', required=True)
        parser.add_argument('password', location='json', required=True)
        args = parser.parse_args()

        password = args["password"]

        # DEPRECATED
        # password = hashlib.md5(password.encode()).hexdigest()

        qry = User.query.filter_by(email=args["email_or_username"]).first()
        if not qry:
            qry = User.query.filter_by(username=args["email_or_username"]).first()
            if not qry:
                return {'status':'failed', 'result': 'UNAUTHORIZED | invalid key or secret'}, 401

        # checking password
        result = validate_password(password, qry.password)
        if not result:
            return {'status':'failed', 'result': 'UNAUTHORIZED | invalid key or secret'}, 401
        res = token_gen(args['email_or_username'], qry=qry)
        return {"status":"success",'result': res}, 200, {'Content-Type':'application/json'}

    def options(self):
        return {}, 200

class TokenResource(Resource):
    # @jwt_required()
    # def get(self):
    #     """get profile"""
    #     claims = get_jwt()
    #     return {"status":"success", 'result': claims}, 200, {'Content-Type':'application/json'}

    @jwt_required(refresh=True)
    def post(self):
        """refresh token"""
        current_user = get_jwt_identity()
        res = token_gen(current_user)
        return {"status":"success",'result': res}, 200, {'Content-Type':'application/json'}

    def options(self):
        return {}, 200

api.add_resource(LoginResource, '/api/v1/login', '/api/v1/login')
api.add_resource(TokenResource, '/api/v1/refresh', '/api/v1/refresh')