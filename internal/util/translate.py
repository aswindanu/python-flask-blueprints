from json import dumps, loads
from translate import Translator

from infrastructure.cached.cookies import get_cookie


DEFAULT_FROM_LANG = "en"
DEFAULT_TO_LANG = "id"

def translate(result, from_lang=DEFAULT_FROM_LANG, to_lang=DEFAULT_TO_LANG):
    to_lang = get_cookie("language") or to_lang
    translator = Translator(from_lang=from_lang, to_lang=to_lang)
    try:
        if isinstance(result, dict):
            return loads(
                translator.translate(
                    dumps(result)
                )
            )
        return translator.translate(str(result))
    except Exception:
        return result