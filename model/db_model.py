import enum
from sqlalchemy import Column, ForeignKey, Integer, String

from python.app import db


class KelaminEnum(enum.Enum):
    L = 1
    P =2

# == Model ==
class Myfamily(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nama = db.Column(db.String(30),  nullable=False)
    kelamin = db.Column(db.Enum(KelaminEnum), nullable=False, )
    orang_tua_id = db.Column(db.Integer, nullable=True)

    @property
    def serialize(self):
        return {
            'id': self.id,
            'name': self.nama,
            'gender': self.kelamin.name,
            'parent_id': self.orang_tua_id
        }