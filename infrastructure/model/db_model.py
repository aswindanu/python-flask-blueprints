from datetime import date, datetime
from email.policy import default
from secrets import choice
import enum

from flask_restful import fields

from app import db


# == Model ==
class User(db.Model):
    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    language_id = db.Column(db.String, db.ForeignKey('language.id'))
    email = db.Column(db.String, nullable=False)
    username = db.Column(db.String, nullable=False, unique=True)
    password = db.Column(db.String, nullable=False)
    fullname = db.Column(db.String, nullable=False)
    phone = db.Column(db.String, nullable=False)
    gender = db.Column(db.Enum("M", "F", name='gender_types'), nullable=False)
    active = db.Column(db.Boolean, nullable=False, default=True)
    ip_address = db.Column(db.String, nullable=False, default=True)
    created_at = db.Column(db.DateTime, default=datetime.today())
    updated_at = db.Column(db.DateTime, default=datetime.today())

    response_field = {
        'id': fields.Integer,
        'language_id': fields.String,
        'email': fields.String,
        'username': fields.String,
        # 'password': fields.String,
        'fullname': fields.String,
        'phone': fields.String,
        'gender': fields.String,
        'active': fields.Boolean,
        # 'ip_address': fields.String,
        'created_at': fields.DateTime,
        'updated_at': fields.DateTime,
    }

    def __init__(
        self, 
        language_id,
        email,
        username,
        password,
        fullname,
        phone,
        gender,
        ip_address,
        active=True,
    ) -> None:
        self.language_id = language_id
        self.email = email
        self.username = username
        self.password = password
        self.fullname = fullname
        self.phone = phone
        self.gender = gender
        self.active = active
        self.ip_address = ip_address

    def update(self, args):
        self.language_id = args.get("language_id", self.language_id)
        self.email = args.get("email", self.email)
        self.username = args.get("username", self.username)
        self.password = args.get("password", self.password)
        self.fullname = args.get("fullname", self.fullname)
        self.phone = args.get("phone", self.phone)
        self.gender = args.get("gender", self.gender)
        self.active = args.get("active", self.active)
        self.ip_address = args.get("ip_address", self.ip_address)


class Weight(db.Model):
    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    max = db.Column(db.Integer, nullable=False)
    min = db.Column(db.Integer, nullable=False)
    margin = db.Column(db.Integer, nullable=False)
    date = db.Column(db.Date, default=date.today(),  nullable=False)

    response_field = {
        'id': fields.Integer,
        'max': fields.Integer,
        'min': fields.Integer,
        'margin': fields.Integer,
        'date': fields.String,
    }
    
    def __init__(self, max, min, margin, date) -> None:
        self.max = max
        self.min = min
        self.margin = margin
        self.date = date

    def update(self, args):
        self.max = args.get("max", self.max)
        self.min = args.get("min", self.min)
        self.margin = args.get("margin", self.margin)
        self.date = args.get("date", self.date)


class Language(db.Model):
    id = db.Column(db.String, nullable=False, primary_key=True)
    language = db.Column(db.String, nullable=False)
    active = db.Column(db.String, nullable=False, default=True)
    users = db.relationship('User', backref='language')

    response_field = {
        'id': fields.String,
        'language': fields.String,
        'active': fields.String,
    }

    def __init__(self, id, language, active=True) -> None:
        self.id = id
        self.language = language
        self.active = active

    def update(self, args):
        self.id = args.get("id", self.id)
        self.language = args.get("language", self.language)
        self.active = args.get("active", self.active)