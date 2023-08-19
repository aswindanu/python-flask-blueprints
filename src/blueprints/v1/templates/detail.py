# -*- coding: utf-8 -*-
import hashlib, datetime

from flask import Blueprint
from flask_restful import Resource, Api, reqparse, marshal, inputs, request

from infrastructure.model import Weight
from src import success_template

bp_detail = Blueprint('detail', __name__)
api = Api(bp_detail)


class DetailResource(Resource):

    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', location='args', required=True)
        args = parser.parse_args()

        qry = Weight.query.get(args["id"])

        return success_template('detail.html', marshal(qry, Weight.response_field))

    def options(self):
        return {}, 200


api.add_resource(DetailResource, '/detail', '/detail')
