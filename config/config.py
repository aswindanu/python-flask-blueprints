import os

# APP
DEBUG = os.getenv("FLASK_ENV").lower() != "production"
TOKEN_EXP = os.getenv("TOKEN_EXP") or 1
REFRESH_TOKEN_EXP = os.getenv("REFRESH_TOKEN_EXP") or 30


# SWAGGER
SWAGGER_URL = '/api/docs'  # URL for exposing Swagger UI (without trailing '/')
# API_URL = 'http://petstore.swagger.io/v2/swagger.json'  # Our API url (can of course be a local resource)
API_URL = '/static/swagger.yaml'
SWAGGER_YAML_PATH = 'static/swagger.yaml'
SWAGGER_YAML_PATH_TMP = 'static/swagger-tmp.yaml'