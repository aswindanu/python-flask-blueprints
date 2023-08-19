import os
import sys
from json import loads
from pathlib import Path
from dotenv import load_dotenv

from flask import Flask, current_app as apps, jsonify
from flask_cors import CORS, cross_origin
from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager


# Load .env Python
env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path)

# Flask APP
app = Flask(__name__)
cors = CORS(app, resources={r"/api/*": {"origins": "*"}})

DEBUG = os.getenv("FLASK_ENV").lower() == "development"

app.config['APP_DEBUG'] = DEBUG
app.config['PROPAGATE_EXCEPTIONS'] = DEBUG
app.config['CORS_HEADERS'] = 'Content-Type'

# DATABASE
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql+psycopg2://{}:{}@{}:{}/{}".format(
    os.getenv("DB_USERNAME"),
    os.getenv("DB_PASSWORD"),
    os.getenv("DB_HOST"),
    os.getenv("DB_PORT"),
    os.getenv("DB_NAME"),
)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config["JWT_SECRET_KEY"] = os.getenv("JWT_SECRET_KEY")  # Change this!

db = SQLAlchemy(app)
migrate = Migrate(app, db)
jwt = JWTManager(app)

# MODULES
import src

@app.route('/')
def hello():
   return src.success_template('home.html', [])

app.register_blueprint(src.bp_index)
app.register_blueprint(src.bp_detail)
app.register_blueprint(src.bp_crud)
app.register_blueprint(src.bp_user)
app.register_blueprint(src.bp_auth)

app.app_context().push()
db.create_all()
