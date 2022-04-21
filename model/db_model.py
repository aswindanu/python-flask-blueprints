from datetime import date, datetime
from email.policy import default
from secrets import choice

import enum
from flask_restful import fields

from app import db


# == Model ==
class BeratBadan(db.Model):
    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    max = db.Column(db.Integer, nullable=False)
    min = db.Column(db.Integer, nullable=False)
    perbedaan = db.Column(db.Integer, nullable=False)
    tanggal = db.Column(db.Date, default=date.today(),  nullable=False)

    response_field = {
        'id': fields.Integer,
        'max': fields.Integer,
        'min': fields.Integer,
        'perbedaan': fields.Integer,
        'tanggal': fields.String,
    }
    
    def __init__(self, max, min, perbedaan, tanggal) -> None:
        self.max = max
        self.min = min
        self.perbedaan = perbedaan
        self.tanggal = tanggal


class User(db.Model):
    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    email = db.Column(db.String, nullable=False)
    username = db.Column(db.String, nullable=False)
    password = db.Column(db.String, nullable=False)
    fullname = db.Column(db.String, nullable=False)
    phone = db.Column(db.String, nullable=False)
    gender = db.Column(db.Enum("M", "F", name='gender_types'), nullable=False)
    active = db.Column(db.Boolean, nullable=False, default=True)
    ip_address = db.Column(db.String, nullable=False, default=True)
    created_at = db.Column(db.DateTime, default=datetime.today(),  nullable=False)
    updated_at = db.Column(db.DateTime, default=datetime.today(),  nullable=False)

    response_field = {
        'id': fields.Integer,
        'email': fields.String,
        'username': fields.String,
        'password': fields.String,
        'fullname': fields.String,
        'phone': fields.String,
        'gender': fields.String,
        'active': fields.Boolean,
        'ip_address': fields.String,
        'created_at': fields.DateTime,
        'updated_at': fields.DateTime,
    }

    def __init__(
        self, 
        email,
        username,
        password,
        fullname,
        phone,
        gender,
        active,
        ip_address,
        created_at,
        updated_at,
    ) -> None:
        self.email = email
        self.username = username
        self.password = password
        self.fullname = fullname
        self.phone = phone
        self.gender = gender
        self.active = active
        self.ip_address = ip_address
        self.created_at = created_at
        self.updated_at = updated_at
