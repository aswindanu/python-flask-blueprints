from flask_restful import request


def get_cookie(name):
    return request.cookies.get(name)