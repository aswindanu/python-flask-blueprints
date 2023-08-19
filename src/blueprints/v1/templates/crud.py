# -*- coding: utf-8 -*-
import hashlib
from datetime import date, datetime

from flask import Blueprint, redirect
from flask_restful import Resource, Api, reqparse, marshal, inputs, request

from infrastructure.model.db_model import db, Weight
from src import success_template, error_template


bp_crud = Blueprint('crud', __name__)
api = Api(bp_crud)


class CrudResource(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', location='args')
        args = parser.parse_args()

        qry = Weight.query.get(args["id"])
        if not qry:
            return success_template('crud.html', [])
        return success_template('crud.html', marshal(qry, Weight.response_field))

    def post(self):
        if not request.form['max'] or not request.form['min'] or not request.form['date']:
            return error_template('crud.html', [], 'All forms should be filled', 400)

        try:
            if int(request.form['max']) < int(request.form['min']):
                return error_template('crud.html', [], 'Data \'max\' should bigger than \'min\'', 400)
            maximum = int(max(request.form['max'], request.form['min']))
            minimum = int(min(request.form['max'], request.form['min']))
        except Exception:
            return error_template('crud.html', [], 'Data max / min should be numeric', 400)
    
        try:
            date = datetime.strptime(request.form['date'], "%Y-%m-%d")
        except Exception:
            return error_template('crud.html', [], 'Data date should be date', 400)

        margin = maximum - minimum
        berat = Weight(request.form['max'], request.form['min'], margin, date)

        try:
            db.session.add(berat)
            db.session.commit()
        except Exception:
            return error_template('crud.html', [], 'Data \'ID\' already exist', 400)

        return redirect(f"/detail?id={berat.id}")

    def options(self):
        return {}, 200


class EditResource(Resource):
    def post(self):
        if not request.form['max'] or not request.form['min'] or not request.form['date']:
            return error_template('crud.html', [], 'All forms should be filled', 400)

        qry = Weight.query.get(request.form["id"])

        try:
            if int(request.form['max']) < int(request.form['min']):
                return error_template('crud.html', [], 'Data \'max\' should bigger than \'min\'', 400)
            maximum = int(max(request.form['max'], request.form['min']))
            minimum = int(min(request.form['max'], request.form['min']))
        except Exception:
            return error_template('crud.html', [], 'Data max / min should be numeric', 400)
    
        try:
            date = datetime.strptime(request.form['date'], "%Y-%m-%d")
        except Exception:
            return error_template('crud.html', [], 'Data date should be date', 400)

        margin = maximum - minimum
        berat = Weight(request.form['max'], request.form['min'], margin, date)

        try:
            qry.max = maximum
            qry.min = minimum
            qry.margin = margin
            qry.date = date
            db.session.commit()
        except Exception:
            return error_template('crud.html', [], 'Data failed to save', 500)

        return redirect(f"/detail?id={berat.id}")

    def options(self):
        return {}, 200


api.add_resource(CrudResource, '/crud', '/crud')
api.add_resource(EditResource, '/crud', '/crud')
