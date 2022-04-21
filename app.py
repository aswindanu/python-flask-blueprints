import os
import sys
from json import loads
from pathlib import Path
from dotenv import load_dotenv

from flask import Flask
from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager

from util.common import success_template

# Load .env Python
env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path)

# Flask APP
app = Flask(__name__)

DEBUG = loads(os.getenv("DEBUG").lower())
app.config['APP_DEBUG'] = DEBUG
app.config['PROPAGATE_EXCEPTIONS'] = DEBUG

# DATABASE
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql+psycopg2://{}:{}@{}:{}/{}".format(
    os.getenv("DATABASE_USERNAME") or os.getenv("POSTGRES_USERNAME"),
    os.getenv("DATABASE_PASSWORD") or os.getenv("POSTGRES_PASSWORD"),
    os.getenv("DATABASE_HOST") or os.getenv("POSTGRES_HOST"),
    os.getenv("DATABASE_PORT") or os.getenv("POSTGRES_PORT"),
    os.getenv("DATABASE_DATABASE") or os.getenv("POSTGRES_DATABASE"),
)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
migrate = Migrate(app, db)
jwt = JWTManager(app)

@app.route('/')
def hello():
   return success_template('home.html', [])

from blueprints.index import bp_index
from blueprints.detail import bp_detail
from blueprints.crud import bp_crud
from blueprints.user import bp_user
from blueprints.auth import bp_auth

app.register_blueprint(bp_index)
app.register_blueprint(bp_detail)
app.register_blueprint(bp_crud)
app.register_blueprint(bp_user)
app.register_blueprint(bp_auth)

db.create_all()
