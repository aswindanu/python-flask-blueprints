import os
from json import loads
from pathlib import Path
from dotenv import load_dotenv

from flask import Flask
from flask_sqlalchemy import SQLAlchemy

# Load .env Python
env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path)


# Flask APP
app = Flask(__name__)

DEBUG = loads(os.getenv("DEBUG").lower())
app.config['APP_DEBUG'] = DEBUG
app.config['PROPAGATE_EXCEPTIONS'] = DEBUG

# DATABASE
db_uri = os.getenv("DATABASE_URL")
app.config['SQLALCHEMY_DATABASE_URI'] = db_uri
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
# db.init_app(app)

@app.route('/')
def hello():
    return 'Hello, World!'

from . import basic
app.register_blueprint(basic.bp)

db.create_all()
