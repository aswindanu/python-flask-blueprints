# -*- coding: utf-8 -*-
import hashlib
from datetime import date, datetime

from flask import Blueprint, redirect
from flask_restful import Resource, Api, reqparse, marshal, inputs, request
from sqlalchemy import asc, desc, and_, or_

from infrastructure.model.db_model import db, Weight
from src import success_template, error_template


bp_weight = Blueprint('weight', __name__)
api = Api(bp_weight)


class HomeResource(Resource):
    def get(self):
        qry = Weight.query.order_by(desc(Weight.date))
        results = []
        total_weight = 0
        total_loss = 0
        for row in qry.all():
            data = marshal(row, Weight.response_field)
            total_weight += data['weight']
            total_loss += data['loss']
            results.append(data)
        try:
            mean_weight = total_weight / len(results)
        except ZeroDivisionError:
            mean_weight = 0
        try:
            mean_loss = total_loss / len(results)
        except ZeroDivisionError:
            mean_loss = 0
        results.append({
            'date': 'Mean',
            'weight': f'{round(mean_weight, 2)}',
            'loss': f'{round(mean_loss, 2)}',
            'status': 'GO',
        })
        return success_template('home.html', results)

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
            return success_template('edit.html', [])
        return success_template('edit.html', marshal(qry, Weight.response_field))

    def post(self):
        if not request.form['weight'] or not request.form['date']:
            return error_template('home.html', [], 'All forms should be filled', 400)
        try:
            date = datetime.strptime(request.form['date'], "%Y-%m-%d")
        except Exception:
            return error_template('home.html', [], 'Data date should be date', 400)
        try:
            weight = int(request.form['weight'])
            qry = Weight.query.filter(Weight.date <= date).order_by(desc(Weight.date)).first()
            loss = 0
            if qry:
                loss = qry.weight - weight
        except Exception:
            return error_template('home.html', [], 'Data weight should be numeric', 400)
        status = None
        for k, v in Weight.WEIGHT_STATUS.items():
            if weight < k:
                status = v
                break
        data = Weight(weight, loss, status, date)
        try:
            db.session.add(data)
            db.session.commit()
        except Exception as e:
            return error_template('home.html', [], 'Data \'ID\' already exist (%s)' % e, 400)
        return redirect(f"/weight/detail?id={data.id}")

    def options(self):
        return {}, 200


class EditResource(CrudResource):
    def post(self):
        if not request.form['weight'] or not request.form['date']:
            return error_template('edit.html', [], 'All forms should be filled', 400)
        qry = Weight.query.get(request.form["id"])
        try:
            weight = int(request.form['weight'])
            qry = Weight.query.filter(Weight.date <= date).order_by(desc(Weight.date)).first()
            loss = 0
            if qry:
                loss = qry.weight - weight
        except Exception:
            return error_template('edit.html', [], 'Data weight should be numeric', 400)
        try:
            date = datetime.strptime(request.form['date'], "%Y-%m-%d")
        except Exception:
            return error_template('edit.html', [], 'Data date should be date', 400)
        status = None
        for k, v in Weight.WEIGHT_STATUS.items():
            if weight < k:
                status = v
                break
        try:
            qry.weight = weight
            qry.loss = loss
            if status:
                qry.status = status
            qry.date = date
            db.session.commit()
        except Exception as e:
            return error_template('edit.html', [], 'Data failed to save (%s)' % e, 500)
        return redirect(f"/weight/detail?id={qry.id}")


base_uri = "/weight"
api.add_resource(HomeResource, base_uri + '/home', base_uri + '/home')
api.add_resource(DetailResource, base_uri + '/detail', base_uri + '/detail')
api.add_resource(CrudResource, base_uri + '/create', base_uri + '/create')
api.add_resource(EditResource, base_uri + '/edit', base_uri + '/edit')