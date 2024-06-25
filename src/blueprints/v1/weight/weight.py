# -*- coding: utf-8 -*-
import hashlib
from datetime import date, datetime

from flask import Blueprint, redirect
from flask_restful import Resource, Api, reqparse, marshal, inputs, request
from sqlalchemy import desc

from infrastructure.model.db_model import db, Weight
from src import success_template, error_template


bp_weight = Blueprint('weight', __name__)
api = Api(bp_weight)


class HomeResource(Resource):
    def get(self):
        return success_template('home.html', {})

    def options(self):
        return {}, 200


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


class DetailResource(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', location='args', required=True)
        args = parser.parse_args()

        qry = Weight.query.get(args["id"])

        return success_template('detail.html', marshal(qry, Weight.response_field))

    def options(self):
        return {}, 200


class CrudResource(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', location='args')
        args = parser.parse_args()

        qry = Weight.query.get(args["id"])
        if not qry:
            return success_template('create.html', [])
        return success_template('create.html', marshal(qry, Weight.response_field))

    def post(self):
        if not request.form['max'] or not request.form['min'] or not request.form['date']:
            return error_template('create.html', [], 'All forms should be filled', 400)

        try:
            if int(request.form['max']) < int(request.form['min']):
                return error_template('create.html', [], 'Data \'max\' should bigger than \'min\'', 400)
            maximum = int(max(request.form['max'], request.form['min']))
            minimum = int(min(request.form['max'], request.form['min']))
        except Exception:
            return error_template('create.html', [], 'Data max / min should be numeric', 400)
    
        try:
            date = datetime.strptime(request.form['date'], "%Y-%m-%d")
        except Exception:
            return error_template('create.html', [], 'Data date should be date', 400)

        margin = maximum - minimum
        berat = Weight(request.form['max'], request.form['min'], margin, date)

        try:
            db.session.add(berat)
            db.session.commit()
        except Exception:
            return error_template('create.html', [], 'Data \'ID\' already exist', 400)

        return redirect(f"/weight/detail?id={berat.id}")

    def options(self):
        return {}, 200


class EditResource(CrudResource):
    def post(self):
        if not request.form['max'] or not request.form['min'] or not request.form['date']:
            return error_template('create.html', [], 'All forms should be filled', 400)

        qry = Weight.query.get(request.form["id"])

        try:
            if int(request.form['max']) < int(request.form['min']):
                return error_template('create.html', [], 'Data \'max\' should bigger than \'min\'', 400)
            maximum = int(max(request.form['max'], request.form['min']))
            minimum = int(min(request.form['max'], request.form['min']))
        except Exception:
            return error_template('create.html', [], 'Data max / min should be numeric', 400)
    
        try:
            date = datetime.strptime(request.form['date'], "%Y-%m-%d")
        except Exception:
            return error_template('create.html', [], 'Data date should be date', 400)

        margin = maximum - minimum
        try:
            qry.max = maximum
            qry.min = minimum
            qry.margin = margin
            qry.date = date
            db.session.commit()
        except Exception:
            return error_template('create.html', [], 'Data failed to save', 500)

        return redirect(f"/weight/detail?id={qry.id}")

base_uri = "/weight"
api.add_resource(HomeResource, base_uri + '/home', base_uri + '/home')
api.add_resource(IndexResource, base_uri + '/index', base_uri + '/index')
api.add_resource(DetailResource, base_uri + '/detail', base_uri + '/detail')
api.add_resource(CrudResource, base_uri + '/create', base_uri + '/create')
api.add_resource(EditResource, base_uri + '/edit', base_uri + '/edit')