# -*- coding: utf-8 -*-
import hashlib, datetime

from flask import Blueprint, make_response
from flask_restful import Resource, Api, reqparse, marshal, inputs
from sqlalchemy import desc

from infrastructure.model import Weight
from src import success, success_template


bp_index = Blueprint('index', __name__)
api = Api(bp_index)


class IndexResource(Resource):

    def get(self):
        qry = Weight.query
        qry = qry.order_by(desc(Weight.date))

        results = []
        total_max = 0
        total_min = 0
        total_margin = 0
        for row in qry.all():
            data = marshal(row, Weight.response_field)
            total_max += data['max']
            total_min += data['min']
            total_margin += data['margin']
            results.append(data)

        try:
            mean_maximum = total_max / len(results)
        except ZeroDivisionError:
            mean_maximum = 0
        try:
            mean_miniimum = total_min / len(results)
        except ZeroDivisionError:
            mean_miniimum = 0
        try:
            mean_margin = total_margin / len(results)
        except ZeroDivisionError:
            mean_margin = 0
        results.append({
            'date': 'Rata-rata',
            'max': f'{mean_maximum}',
            'min': f'{mean_miniimum}',
            'margin': f'{mean_margin}',
        })

        return success_template('index.html', results)

    def options(self):
        return {}, 200


api.add_resource(IndexResource, '/index', '/index')
