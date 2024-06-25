from datetime import date, datetime
from email.policy import default
from secrets import choice
import enum

from flask_restful import fields

from app import db


# == Model ==
class User(db.Model):
    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    profile_id = db.Column(db.Integer, db.ForeignKey('profile.id'))
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
        'profile_id': fields.Integer,
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
        profile_id,
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
        self.profile_id = profile_id
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
        self.profile_id = args.get("profile_id", self.profile_id)
        self.language_id = args.get("language_id", self.language_id)
        self.email = args.get("email", self.email)
        self.username = args.get("username", self.username)
        self.password = args.get("password", self.password)
        self.fullname = args.get("fullname", self.fullname)
        self.phone = args.get("phone", self.phone)
        self.gender = args.get("gender", self.gender)
        self.active = args.get("active", self.active)
        self.ip_address = args.get("ip_address", self.ip_address)


class Profile(db.Model):
    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    profile_code = db.Column(db.String, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.today())
    updated_at = db.Column(db.DateTime, default=datetime.today())

    response_field = {
        'id': fields.Integer,
        'profile_code': fields.String,
        'created_at': fields.DateTime,
        'updated_at': fields.DateTime,
    }

    def __init__(
        self, 
        profile_code,
    ) -> None:
        self.profile_code = profile_code

    def update(self, args):
        self.profile_code = args.get("profile_code", self.profile_code)

class Weight(db.Model):
    WEIGHT_STATUS = {
        # "nice", "keep it up", "normal", "need diet", "fat!"
        # max weight: status
        40: "nice",
        60: "keep it up",
        70: "normal",
        90: "need diet",
        9999: "fat!",
    }

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    weight = db.Column(db.Integer, nullable=False)
    loss = db.Column(db.Integer, nullable=False)
    status = db.Column(db.Enum(*WEIGHT_STATUS.values(), name='weight_status'), nullable=False)
    date = db.Column(db.Date, default=date.today(),  nullable=False)

    response_field = {
        'id': fields.Integer,
        'weight': fields.Integer,
        'loss': fields.Integer,
        'status': fields.String,
        'date': fields.String,
    }

    def __init__(self, weight, loss, status, date) -> None:
        self.weight = weight
        self.loss = loss
        self.status = status
        self.date = date

    def update(self, args):
        self.weight = args.get("weight", self.weight)
        self.loss = args.get("loss", self.loss)
        self.status = args.get("status", self.status)
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