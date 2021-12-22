from datetime import date

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
