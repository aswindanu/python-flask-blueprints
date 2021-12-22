# -*- coding: utf-8 -*-
import hashlib, datetime

from flask import Blueprint, make_response
from flask_restful import Resource, Api, reqparse, marshal, inputs
from sqlalchemy import desc

from app import db, app
from model.db_model import BeratBadan
from util.common import success, success_template


bp_index = Blueprint('index', __name__)
api = Api(bp_index)


class IndexResource(Resource):

    def get(self):
        qry = BeratBadan.query
        qry = qry.order_by(desc(BeratBadan.tanggal))

        results = []
        total_max = 0
        total_min = 0
        total_perbedaan = 0
        for row in qry.all():
            data = marshal(row, BeratBadan.response_field)
            total_max += data['max']
            total_min += data['min']
            total_perbedaan += data['perbedaan']
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
            mean_perbedaan = total_perbedaan / len(results)
        except ZeroDivisionError:
            mean_perbedaan = 0
        results.append({
            'tanggal': 'Rata-rata',
            'max': f'{mean_maximum}',
            'min': f'{mean_miniimum}',
            'perbedaan': f'{mean_perbedaan}',
        })

        return success_template('index.html', results)

    def options(self):
        return {}, 200


api.add_resource(IndexResource, '/index', '/index')
