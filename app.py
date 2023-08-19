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

import src


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
    os.getenv("DB_USERNAME") or os.getenv("POSTGRES_USERNAME"),
    os.getenv("DB_PASSWORD") or os.getenv("POSTGRES_PASSWORD"),
    os.getenv("DB_HOST") or os.getenv("POSTGRES_HOST"),
    os.getenv("DB_PORT") or os.getenv("POSTGRES_PORT"),
    os.getenv("DB_NAME") or os.getenv("POSTGRES_DATABASE"),
)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config["JWT_SECRET_KEY"] = os.getenv("JWT_SECRET_KEY")  # Change this!

db = SQLAlchemy(app)
migrate = Migrate(app, db)
jwt = JWTManager(app)

# MODULES
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





# # ===== FIXME ======
"""OpenAPI v3 Specification"""

# apispec via OpenAPI
from apispec import APISpec
from apispec.ext.marshmallow import MarshmallowPlugin
from apispec_webframeworks.flask import FlaskPlugin
from marshmallow import Schema, fields

# Create an APISpec
spec = APISpec(
    title="My App",
    version="1.0.0",
    openapi_version="3.0.2",
    plugins=[FlaskPlugin(), MarshmallowPlugin()],
)

# Define schemas
# class InputSchema(Schema):
#     number = fields.Int(description="An integer.", required=True)

# class OutputSchema(Schema):
#     msg = fields.String(description="A message.", required=True)

# # register schemas with spec
# spec.components.schema("Input", schema=InputSchema)
# spec.components.schema("Output", schema=OutputSchema)

# # add swagger tags that are used for endpoint annotation
# tags = [
#             {'name': 'test functions',
#              'description': 'For testing the API.'
#             },
#             {'name': 'calculation functions',
#              'description': 'Functions for calculating.'
#             },
#        ]

# for tag in tags:
#     print(f"Adding tag: {tag['name']}")
#     spec.tag(tag)

with app.test_request_context():
    # register all swagger documented functions here
    for fn_name in app.view_functions:
        if fn_name == 'static':
            continue
        print(f"Loading swagger docs for function: {fn_name}")
        view_fn = app.view_functions[fn_name]
        # open("DEBUG.txt","a").write(f"TRY {view_fn}\n")
        spec.path(view=view_fn)

# # Flask swagger UI
from flask_swagger_ui import get_swaggerui_blueprint

@app.route("/api/v1/swagger.json")
def create_swagger_spec():
    # open("DEBUG.txt","a").write(f"{spec.to_dict()}\n")
    return jsonify(spec.to_dict())
    filename = os.path.join(apps.root_path, '..', 'swagger.json')
    with open(filename) as test_file:
        data = json.load(test_file)
        return data

SWAGGER_URL = '/api/v1/swagger-docs'  # URL for exposing Swagger UI (without trailing '/')
API_URL = '/api/v1/swagger.json'  # Our API url (can of course be a local resource)

# Call factory function to create our blueprint
swaggerui_blueprint = get_swaggerui_blueprint(
    SWAGGER_URL,  # Swagger UI static files will be mapped to '{SWAGGER_URL}/dist/'
    API_URL,
    config={  # Swagger UI config overrides
        'app_name': "Flask application"
    },
    # oauth_config={  # OAuth config. See https://github.com/swagger-api/swagger-ui#oauth2-configuration .
    #    'clientId': "your-client-id",
    #    'clientSecret': "your-client-secret-if-required",
    #    'realm': "your-realms",
    #    'appName': "your-app-name",
    #    'scopeSeparator': " ",
    #    'additionalQueryStringParams': {'test': "hello"}
    # }
)

app.register_blueprint(swaggerui_blueprint)
# # =====