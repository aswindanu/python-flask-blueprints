# COMMON
from .common.common import *

# ERROR
from .error.error import *

# MODULES (v1)
from .blueprints.v1.templates.index import bp_index
from .blueprints.v1.templates.detail import bp_detail
from .blueprints.v1.templates.crud import bp_crud

from .blueprints.v1.rest.user import bp_user
from .blueprints.v1.rest.auth import bp_auth