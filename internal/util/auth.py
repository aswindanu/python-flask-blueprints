from flask_restful import Api, Resource, reqparse, marshal
from flask_jwt_extended import (
    create_access_token, create_refresh_token, 
    jwt_required,
    get_jwt_identity, get_jwt
)

from infrastructure.model.db_model import User


def token_gen(identity, qry=None, claim=None):
    refresh_token = None
    if qry:
        claim = marshal(qry, User.response_field)
        refresh_token = create_refresh_token(identity=identity, additional_claims=claim)
    res = {
        "access_token": create_access_token(identity=identity, additional_claims=claim)
    }
    if refresh_token:
        res["refresh_token"] = refresh_token
    return res