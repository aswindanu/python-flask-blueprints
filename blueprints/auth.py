import json, hashlib

from flask import Blueprint
from flask_restful import Api, Resource, reqparse, marshal
from flask_jwt_extended import create_access_token, jwt_required, get_jwt

from app import db, app
from model.db_model import User

bp_auth = Blueprint('auth', __name__)
api = Api(bp_auth)

class LoginResource(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('email_or_username', location='args', required=True)
        parser.add_argument('password', location='args', required=True)
        args = parser.parse_args()

        # password = hashlib.md5(args['password'].encode()).hexdigest()
        password = args["password"]

        qry = User.query.filter_by(email=args["email_or_username"], password=args["password"]).first()
        if qry:
            claim = marshal(qry, User.response_field)
            token = create_access_token(identity=args['email_or_username'], additional_claims=claim)
            return {"status":"success",'result': token}, 200, {'Content-Type':'application/json'}
        qry = User.query.filter_by(username=args["email_or_username"], password=args["password"]).first()
        if qry:
            claim = marshal(qry, User.response_field)
            token = create_access_token(identity=args['email_or_username'], additional_claims=claim)
            return {"status":"success",'result': token}, 200, {'Content-Type':'application/json'}
        return {'status':'failed', 'result': 'UNAUTHORIZED | invalid key or secret'}, 401

    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('email_or_username', location='json', required=True)
        parser.add_argument('password', location='json', required=True)
        args = parser.parse_args()

        # password = hashlib.md5(args['password'].encode()).hexdigest()
        password = args["password"]

        qry = User.query.filter_by(email=args["email_or_username"], password=args["password"]).first()
        if qry:
            claim = marshal(qry, User.response_field)
            token = create_access_token(identity=args['email_or_username'], additional_claims=claim)
            return {"status":"success",'result': token}, 200, {'Content-Type':'application/json'}
        qry = User.query.filter_by(username=args["email_or_username"], password=args["password"]).first()
        if qry:
            claim = marshal(qry, User.response_field)
            token = create_access_token(identity=args['email_or_username'], additional_claims=claim)
            return {"status":"success",'result': token}, 200, {'Content-Type':'application/json'}
        return {'status':'failed', 'result': 'UNAUTHORIZED | invalid key or secret'}, 401

    # @jwt_required()
    # def get(self):
    #     claims = get_jwt()
    #     return {"status":"success", 'result': claims}, 200, {'Content-Type':'application/json'}

    def options(self):
        return {}, 200

api.add_resource(LoginResource, '/login', '/login')