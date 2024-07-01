from typing import Any
from typing import Optional
from typing import Sequence
from typing import Tuple
from typing import Union

from functools import wraps
from flask import (
    render_template, 
    make_response, 
    request,
    redirect as flask_redirect, 
    url_for,
    current_app,
)
from flask_jwt_extended import (
    get_jwt_identity, get_jwt,
    set_access_cookies,
    set_refresh_cookies,
)
from flask_jwt_extended.view_decorators import (
    verify_jwt_in_request, 
    _decode_jwt_from_request,
)


def jwt_required(
    optional: bool = False,
    fresh: bool = False,
    refresh: bool = False,
    locations: Any = None,
    verify_type: bool = True,
    skip_revocation_check: bool = False,
    redirect: bool = False,
):
    """
    Details : https://github.com/vimalloc/flask-jwt-extended/blob/master/flask_jwt_extended/view_decorators.py
    """
    def wrapper(fn):
        @wraps(fn)
        def decorator(*args, **kwargs):
            try:
                verify_jwt_in_request(
                    optional, fresh, refresh, locations, verify_type, skip_revocation_check
                )
            except Exception:
                if not redirect and not optional:
                    raise
                return flask_redirect(url_for("auth.logintemplate"))
            return current_app.ensure_sync(fn)(*args, **kwargs)

        return decorator
    return wrapper