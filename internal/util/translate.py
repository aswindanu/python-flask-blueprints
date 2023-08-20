from json import dumps, loads
from translate import Translator


DEFAULT_FROM_LANG = "en"
DEFAULT_TO_LANG = "id"

def translate(res, from_lang=DEFAULT_FROM_LANG, to_lang=DEFAULT_TO_LANG):
    translator = Translator(from_lang=from_lang, to_lang=to_lang)
    if isinstance(res, dict):
        return loads(
            translator.translate(
                dumps(res)
            )
        )
    return translator.translate(str(res))