import os
from json import loads
from pathlib import Path
from datetime import timedelta
from dotenv import load_dotenv

from flask import (
    Flask, 
    current_app as apps, 
    jsonify, 
    redirect, 
    url_for
)
from flask_caching import Cache
from flask_cors import CORS, cross_origin
from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager
from flask_wtf.csrf import CSRFProtect

from config.config import DEBUG, TOKEN_EXP, REFRESH_TOKEN_EXP


# Load .env Python
env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path)

# Flask APP
app = Flask(__name__)
cors = CORS(app, resources={r"/api/*": {"origins": "*"}})

app.config['APP_DEBUG'] = DEBUG
app.config['PROPAGATE_EXCEPTIONS'] = DEBUG
app.config['SESSION_COOKIE_SECURE'] = not DEBUG

app.config['JWT_COOKIE_SECURE'] = not DEBUG
app.config['JWT_TOKEN_LOCATION'] = ['cookies']
# app.config['JWT_ACCESS_COOKIE_PATH'] = '/api/'
# app.config['JWT_REFRESH_COOKIE_PATH'] = '/token/refresh'

app.config['CORS_HEADERS'] = 'Content-Type'

app.config["JWT_SECRET_KEY"] = os.getenv("JWT_SECRET_KEY")  # Change this!
app.config["SECRET_KEY"] = os.getenv("JWT_SECRET_KEY")  # Change this!

app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(hours=int(TOKEN_EXP))
app.config['JWT_REFRESH_TOKEN_EXPIRES'] = timedelta(days=int(REFRESH_TOKEN_EXP))

app.config["CACHE_TYPE"] = "SimpleCache"
app.config["CACHE_DEFAULT_TIMEOUT"] = 1000

# DATABASE
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql+psycopg2://{}:{}@{}:{}/{}".format(
    os.getenv("DB_USERNAME"),
    os.getenv("DB_PASSWORD"),
    os.getenv("DB_HOST"),
    os.getenv("DB_PORT"),
    os.getenv("DB_NAME"),
)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False


# https://github.com/wtforms/flask-wtf/blob/65dbb59ff519a5757633472040b1646c2b456ab0/src/flask_wtf/csrf.py#L203
csrf = CSRFProtect(app)
# app.config["WTF_CSRF_ENABLED"] = False #XXX
# app.config["WTF_CSRF_CHECK_DEFAULT"] = False #XXX

cache = Cache(app)
db = SQLAlchemy(app)
migrate = Migrate(app, db)
jwt = JWTManager(app)

from route import *

app.app_context().push()
db.create_all()
