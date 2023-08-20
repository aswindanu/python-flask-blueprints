# https://pypi.org/project/flask-swagger-ui/
from flask_swagger_ui import get_swaggerui_blueprint

# https://pypi.org/project/flask-swagger-generator/
from flask_swagger_generator.generators import Generator
from flask_swagger_generator.utils import SecurityType, SwaggerVersion

# https://lyz-code.github.io/yamlfix/
from yamlfix import fix_files
from yaml import SafeLoader, load, dump

SWAGGER_URL = '/api/docs'  # URL for exposing Swagger UI (without trailing '/')
# API_URL = 'http://petstore.swagger.io/v2/swagger.json'  # Our API url (can of course be a local resource)
API_URL = '/static/swagger.yaml'
SWAGGER_YAML_PATH = 'static/swagger.yaml'
SWAGGER_YAML_PATH_TMP = 'static/swagger-tmp.yaml'

# SWAGGER UI
swaggerui_blueprint = get_swaggerui_blueprint(
    SWAGGER_URL,  # Swagger UI static files will be mapped to '{SWAGGER_URL}/dist/'
    API_URL,
    config={  # Swagger UI config overrides
        'app_name': "Test application"
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

# SWAGGER.YAML GENERATOR
generator = Generator.of(SwaggerVersion.VERSION_THREE)

# YAMLFIX
class UniqueKeyLoader(SafeLoader):
    def construct_mapping(self, node, deep=False):
        mapping = []
        for key_node, value_node in node.value:
            key = self.construct_object(key_node, deep=deep)
            # open("debug.txt","a").write(f"key {key} value_node{value_node}\n")
            if key in mapping:
                continue
            mapping.append(key)
        return super().construct_mapping(node, deep)

def generate_yaml():
    # with fix_files([SWAGGER_YAML_PATH_TMP]):
    tmp_yaml = open((SWAGGER_YAML_PATH_TMP), 'r').read()
    new_yaml = open((SWAGGER_YAML_PATH), 'w')
    text = load(tmp_yaml, Loader=UniqueKeyLoader)
    # open("debug.txt","a").write(f"{str(text)}\n")
    dump(text, new_yaml, default_flow_style=False)