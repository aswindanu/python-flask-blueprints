from flask_restful import Api, Resource, reqparse, marshal
from flask_jwt_extended import (
    create_access_token, create_refresh_token, 
    jwt_required,
    get_jwt_identity, get_jwt
)

from infrastructure.model.db_model import User, Language
from internal.util.translate import DEFAULT_TO_LANG

def get_username():
    return get_jwt_identity()

def token_gen(identity, qry=None, claim=None):
    refresh_token = None
    language = DEFAULT_TO_LANG
    if qry:
        language = qry.language_id or language
        claim = marshal(qry, User.response_field)
        refresh_token = create_refresh_token(identity=identity, additional_claims=claim)
    res = {
        "access_token": create_access_token(identity=identity, additional_claims=claim),
        "language": language,
    }
    if refresh_token:
        res["refresh_token"] = refresh_token
    return res