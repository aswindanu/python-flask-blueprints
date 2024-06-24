# COMMON
from .common.common import *

# ERROR
from .error.error import *

# SWAGGER
from .swagger.swagger import *

# MODULES (v1)
from .blueprints.v1.user.auth import bp_auth
from .blueprints.v1.user.user import bp_user
from .blueprints.v1.weight.weight import bp_weight