# """OpenAPI v3 Specification"""

# # apispec via OpenAPI
# from apispec import APISpec
# from apispec.ext.marshmallow import MarshmallowPlugin
# from apispec_webframeworks.flask import FlaskPlugin
# from marshmallow import Schema, fields

# # Create an APISpec
# spec = APISpec(
#     title="My App",
#     version="1.0.0",
#     openapi_version="3.0.2",
#     plugins=[FlaskPlugin(), MarshmallowPlugin()],
# )

# # Define schemas
# # class InputSchema(Schema):
# #     number = fields.Int(description="An integer.", required=True)

# # class OutputSchema(Schema):
# #     msg = fields.String(description="A message.", required=True)

# # # register schemas with spec
# # spec.components.schema("Input", schema=InputSchema)
# # spec.components.schema("Output", schema=OutputSchema)

# # # add swagger tags that are used for endpoint annotation
# # tags = [
# #             {'name': 'test functions',
# #              'description': 'For testing the API.'
# #             },
# #             {'name': 'calculation functions',
# #              'description': 'Functions for calculating.'
# #             },
# #        ]

# # for tag in tags:
# #     print(f"Adding tag: {tag['name']}")
# #     spec.tag(tag)

# with app.test_request_context():
#     # register all swagger documented functions here
#     for fn_name in app.view_functions:
#         if fn_name == 'static':
#             continue
#         print(f"Loading swagger docs for function: {fn_name}")
#         view_fn = app.view_functions[fn_name]
#         # open("DEBUG.txt","a").write(f"TRY {view_fn}\n")
#         spec.path(view=view_fn)

# # # Flask swagger UI
# from flask_swagger_ui import get_swaggerui_blueprint

# @app.route("/api/v1/swagger.json")
# def create_swagger_spec():
#     # open("DEBUG.txt","a").write(f"{spec.to_dict()}\n")
#     return jsonify(spec.to_dict())
#     filename = os.path.join(apps.root_path, '..', 'swagger.json')
#     with open(filename) as test_file:
#         data = json.load(test_file)
#         return data

# SWAGGER_URL = '/api/v1/swagger-docs'  # URL for exposing Swagger UI (without trailing '/')
# API_URL = '/api/v1/swagger.json'  # Our API url (can of course be a local resource)

# # Call factory function to create our blueprint
# swaggerui_blueprint = get_swaggerui_blueprint(
#     SWAGGER_URL,  # Swagger UI static files will be mapped to '{SWAGGER_URL}/dist/'
#     API_URL,
#     config={  # Swagger UI config overrides
#         'app_name': "Flask application"
#     },
#     # oauth_config={  # OAuth config. See https://github.com/swagger-api/swagger-ui#oauth2-configuration .
#     #    'clientId': "your-client-id",
#     #    'clientSecret': "your-client-secret-if-required",
#     #    'realm': "your-realms",
#     #    'appName': "your-app-name",
#     #    'scopeSeparator': " ",
#     #    'additionalQueryStringParams': {'test': "hello"}
#     # }
# )

# app.register_blueprint(swaggerui_blueprint)
# # # =====