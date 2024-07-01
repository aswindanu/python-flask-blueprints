import json, hashlib

from flask import (
    Blueprint,
    redirect, 
    url_for
)
from flask_restful import Api, Resource, reqparse, marshal, request
from flask_swagger_generator.utils import SecurityType

from infrastructure.model.db_model import User, Profile
from internal.service.middleware import (
    jwt_required,
)
from internal.util.auth import token_gen, get_username
from internal.util.encrypt import validate_password, hash_password
from internal.service.crud import ParentResource
from src.blueprints.v1.user.form import AuthForm
from src.swagger.swagger import generator


bp_auth = Blueprint('auth', __name__)
api = Api(bp_auth)


# API Auth
class BaseResource(ParentResource):
    def __init__(self):
        super().__init__(model=User, form=AuthForm)
        self.bypass_login = True


class AuthResource(BaseResource):
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
            "profile_id": 1,
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
        return self.response(claims)

    # Add security, response and request body definitions
    @generator.response(status_code=200, schema={
        "status": "success",
        "result": {
            "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
            "profile": "ADMIN",
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
                return self.response({'status':'failed', 'result': 'UNAUTHORIZED | invalid key or secret'}, 401)
        # checking password
        result = validate_password(password, qry.password)
        if not result:
            return self.response({'status':'failed', 'result': 'UNAUTHORIZED | invalid key or secret'}, 401)
        res = token_gen(args['email_or_username'], qry=qry)
        self.is_login = True
        self.profile_code = Profile.query.filter_by(id=qry.profile_id).first().profile_code
        return self.response(res)

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
            return self.response({'status':'failed',"result":"ID Not Found"}, 404)
        args["password"] = hash_password(args["password"])
        args["ip_address"] = request.remote_addr

        return super().update_data(qry.id, args)

    def options(self):
        return {}, 200


class TokenResource(AuthResource):
    @jwt_required(refresh=True)
    def post(self):
        """refresh token"""
        current_user = get_username()
        res = token_gen(current_user)
        return self.response(res)

    def options(self):
        return {}, 200


# Login Page
class LoginTemplate(BaseResource):
    def get(self):
        return self.success_template('login.html')

    def post(self):
        """login"""
        args = request.form
        password = args["password"]
        qry = User.query.filter_by(email=args["email_or_username"]).first()
        if not qry:
            qry = User.query.filter_by(username=args["email_or_username"]).first()
            if not qry:
                return self.error_template(message='UNAUTHORIZED | invalid key or secret')
        # checking password
        result = validate_password(password, qry.password)
        if not result:
            return self.error_template(message='UNAUTHORIZED | invalid key or secret')
        res = token_gen(args['email_or_username'], qry=qry)
        context = {
            "access_token": res["access_token"],
            "refresh_token": res["refresh_token"],
            "cookies": []
        }
        self.cache.set("is_login", True)
        self.cache.set("user_id", str(qry.id))
        self.cache.set("profile_code", Profile.query.filter_by(id=qry.profile_id).first().profile_code)
        return self.success_template("weight.hometemplate", redirect_modules=True, context=context)

class LogoutTemplate(BaseResource):
    @jwt_required()
    def get(self):
        session = request.cookies.get("session")
        self.cache.clear()
        context = {
            "reset_token": True,
        }
        if session:
            context["cookies"] = [("session", session)]
        return self.success_template('login.html', context=context)


# api
api.add_resource(AuthResource, '/api/v1/auth', '/api/v1/auth')
api.add_resource(TokenResource, '/api/v1/refresh', '/api/v1/refresh')
# page
api.add_resource(LoginTemplate, '/login', '/login')
api.add_resource(LogoutTemplate, '/logout', '/logout')