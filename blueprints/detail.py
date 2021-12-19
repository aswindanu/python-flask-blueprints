# -*- coding: utf-8 -*-
import hashlib, datetime

from flask import Blueprint
from flask_restful import Resource, Api, reqparse, marshal, inputs

from app import db, app
from model.db_model import BeratBadan
from util.common import success_template

bp_detail = Blueprint('detail', __name__)
api = Api(bp_detail)


class DetailResource(Resource):

    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', location='args', required=True)
        args = parser.parse_args()

        qry = BeratBadan.query.get(args["id"])

        return success_template('detail.html', marshal(qry, BeratBadan.response_field))

    def options(self):
        return {}, 200


api.add_resource(DetailResource, '/detail', '/detail')
