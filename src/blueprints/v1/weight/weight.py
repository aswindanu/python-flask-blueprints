# -*- coding: utf-8 -*-
import hashlib
from datetime import date, datetime

from flask import Blueprint, redirect
from flask_restful import Resource, Api, reqparse, marshal, inputs, request
from sqlalchemy import asc, desc, and_, or_
from flask_jwt_extended import (
    jwt_required,
    get_jwt_identity, get_jwt
)

from internal.util.auth import get_username
from infrastructure.model.db_model import db, Weight, User
from src.blueprints.v1.weight.form import WeightForm
from internal.service.crud import ParentResource


bp_weight = Blueprint('weight', __name__)
api = Api(bp_weight)


class BaseResource(ParentResource):
    def __init__(self):
        super().__init__(model=Weight, form=WeightForm)
        self.bypass_login = False


class HomeTemplate(BaseResource):
    @jwt_required()
    def get(self):
        username = get_username()
        user = User.query.filter(User.username == username).first()
        if not user:
            return self.error_template(message='Login is required haha', status_code=400)
        qry = Weight.query.filter(Weight.user_id == user.id).order_by(desc(Weight.date))
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
            'status': '-',
        })
        return self.success_template('weight/home.html', results=results)

    # @jwt_required() #XXX
    def post(self):
        if not request.form['weight'] or not request.form['date']:
            return self.error_template(message='All forms should be filled', status_code=400)
        try:
            date = datetime.strptime(request.form['date'], "%Y-%m-%d")
        except Exception:
            return self.error_template(message='Data date should be date', status_code=400)
        try:
            weight = int(request.form['weight'])
            qry = Weight.query.filter(Weight.date == date).order_by(desc(Weight.date)).first()
            if qry:
                return self.error_template(message='This date is filled. Come back again tomorrow.', status_code=400)
            qry = Weight.query.filter(Weight.date < date).order_by(desc(Weight.date)).first()
            loss = 0
            if qry:
                loss = qry.weight - weight
        except Exception:
            return self.error_template(message='Data weight should be numeric', status_code=400)
        status = None
        for k, v in Weight.WEIGHT_STATUS.items():
            if weight < k:
                status = v
                break
        data = Weight(self.user_id, weight, loss, status, date)
        try:
            db.session.add(data)
            db.session.commit()
        except Exception as e:
            return self.error_template(message='Data \'ID\' already exist (%s)' % e, status_code=400)
        return self.success_template(f"/weight/detail?id={data.id}", redirect_url=True)

    def options(self):
        return {}, 200


class DetailTemplate(BaseResource):
    @jwt_required()
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', location='args', required=True)
        args = parser.parse_args()
        qry = Weight.query.get(args["id"])
        return self.success_template('weight/detail.html', results=marshal(qry, Weight.response_field))

    def options(self):
        return {}, 200


class EditTemplate(BaseResource):
    @jwt_required()
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', location='args')
        args = parser.parse_args()
        qry = Weight.query.get(args["id"])
        if not qry:
            return self.success_template('edit.html')
        return self.success_template('weight/edit.html', results=marshal(qry, Weight.response_field))

    # @jwt_required() #XXX
    def post(self):
        if not request.form['weight'] or not request.form['date']:
            return self.error_template(message='All forms should be filled', status_code=400)
        qry = Weight.query.get(request.form["id"])
        try:
            date = datetime.strptime(request.form['date'], "%Y-%m-%d")
        except Exception:
            return self.error_template(message='Data date should be date', status_code=400)
        try:
            weight = int(request.form['weight'])
            qry = Weight.query.filter(and_(Weight.date < date)).order_by(desc(Weight.date)).first()
            loss = 0
            if qry:
                loss = qry.weight - weight
        except Exception as e:
            return self.error_template(message='Data weight should be numeric (%s)' % e, status_code=400)
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
            return self.error_template(message='Data failed to save (%s)' % e, status_code=500)
        return self.success_template(f"/weight/detail?id={qry.id}", redirect_url=True)
    
    def options(self):
        return {}, 200


base_uri = "/weight"
api.add_resource(HomeTemplate, base_uri + '/home', base_uri + '/home')
api.add_resource(DetailTemplate, base_uri + '/detail', base_uri + '/detail')
api.add_resource(EditTemplate, base_uri + '/edit', base_uri + '/edit')