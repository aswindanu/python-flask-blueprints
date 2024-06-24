# MODULES
from flask import (
    redirect, 
    url_for
)

import src
from app import app
from config.config import SWAGGER_YAML_PATH_TMP

@app.route('/')
def hello():
   return redirect(url_for("swagger_ui.show"))

app.register_blueprint(src.bp_weight)
app.register_blueprint(src.bp_user)
app.register_blueprint(src.bp_auth)

# SWAGGER UI
app.register_blueprint(src.swaggerui_blueprint)

# SWAGGER generator
src.generator.generate_swagger(app, destination_path=SWAGGER_YAML_PATH_TMP)

# YAMLFIX
src.generate_yaml()