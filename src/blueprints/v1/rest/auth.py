import json, hashlib

from flask import Blueprint
from flask_restful import Api, Resource, reqparse, marshal, request
from flask_jwt_extended import (
    jwt_required,
    get_jwt_identity, get_jwt
)
from flask_swagger_generator.utils import SecurityType

from infrastructure.model.db_model import User
from internal.util.auth import token_gen, get_username
from internal.util.encrypt import validate_password, hash_password
from internal.service.crud import ParentResource
from src.common.common import response
from src.swagger.swagger import generator


bp_auth = Blueprint('auth', __name__)
api = Api(bp_auth)


class LoginResource(ParentResource):
    def __init__(self):
        super().__init__(model=User)

    # Add security, response and request body definitions
    @generator.security(SecurityType.BEARER_AUTH)
    @generator.response(status_code=200, schema={
        "status": "success",
        "result": {
            "fresh": False,
            "iat": 1692523125,
            "jti": "441a8e0c-b633-4f38-a331-2fdcefa9e80d",
            "type": "access",
            "sub": "aswindanu2",
            "nbf": 1692523125,
            "exp": 1692526725,
            "id": 7,
            "language_id": "id",
            "email": "aswindanu3@tes.io",
            "username": "aswindanu2",
            "fullname": "Aswindanu",
            "phone": "627839273912",
            "gender": "M",
            "active": True,
            "created_at": "Sat, 19 Aug 2023 17:37:02 -0000",
            "updated_at": "Sat, 19 Aug 2023 17:37:02 -0000"
        }
    })
    @bp_auth.route('/api/v1/login', methods=['GET'])
    @jwt_required()
    def get(self):
        """get profile"""
        claims = get_jwt()
        return response(claims)

    # Add security, response and request body definitions
    @generator.response(status_code=200, schema={
        "status": "success",
        "result": {
            "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
            "language": "id",
            "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
        }
    })
    @generator.request_body({'email_or_username': 'abc', 'password': 'password'})
    @bp_auth.route('/api/v1/login', methods=['POST'])
    def post(self):
        """login"""
        parser = reqparse.RequestParser()
        parser.add_argument('email_or_username', location='json', required=True)
        parser.add_argument('password', location='json', required=True)
        args = parser.parse_args()

        password = args["password"]

        qry = User.query.filter_by(email=args["email_or_username"]).first()
        if not qry:
            qry = User.query.filter_by(username=args["email_or_username"]).first()
            if not qry:
                return response({'status':'failed', 'result': 'UNAUTHORIZED | invalid key or secret'}, 401)
        # checking password
        result = validate_password(password, qry.password)
        if not result:
            return response({'status':'failed', 'result': 'UNAUTHORIZED | invalid key or secret'}, 401)
        res = token_gen(args['email_or_username'], qry=qry)
        return response(res)

    # Add security, response and request body definitions
    @generator.security(SecurityType.BEARER_AUTH)
    @generator.response(status_code=200, schema={
        "status": "success",
        "result": {
            "id": 7,
            "language_id": "id",
            "email": "aswindanu3@tes.io",
            "username": "aswindanu2",
            "fullname": "Aswindanu",
            "phone": "627839273912",
            "gender": "M",
            "active": True,
            "created_at": "Sat, 19 Aug 2023 17:37:02 -0000",
            "updated_at": "Sat, 19 Aug 2023 17:37:02 -0000"
        }
    })
    @generator.request_body({'password': 'password'})
    @bp_auth.route('/api/v1/login', methods=['PUT'])
    @jwt_required()
    def put(self):
        """Update password"""
        parser = reqparse.RequestParser()
        parser.add_argument('password', location='json', required=True)
        args = parser.parse_args()

        qry = User.query.filter_by(username=get_username()).first()
        if not qry:
            return response({'status':'failed',"result":"ID Not Found"}, 404)
        args["password"] = hash_password(args["password"])
        args["ip_address"] = request.remote_addr

        return super().update_data(qry.id, args)

    def options(self):
        return {}, 200

class TokenResource(ParentResource):
    def __init__(self):
        super().__init__(model=User)

    @jwt_required(refresh=True)
    def post(self):
        """refresh token"""
        current_user = get_username()
        res = token_gen(current_user)
        return response(res)

    def options(self):
        return {}, 200

api.add_resource(LoginResource, '/api/v1/login', '/api/v1/login')
api.add_resource(TokenResource, '/api/v1/refresh', '/api/v1/refresh')