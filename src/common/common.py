"""
Common function    
"""
from flask import render_template, make_response
from internal.util.translate import translate


def response(result, code=200, enable_translate=False, content_type='application/json'):
    if enable_translate:
        result = translate(result)
    if code == 204 or not content_type:
        return (result, code)
    if code != 200:
        return result, code, {'Content-Type': content_type}
    return {"status":"success", "result": result}, code, {'Content-Type': content_type}

def success_template(html_doc, results):
    headers = {'Content-Type': 'text/html'}
    return make_response(render_template(html_doc, results=results, title="Weight"), 200, headers)

def error_template(html_doc, results, message, status_code):
    headers = {'Content-Type': 'text/html'}
    return make_response(render_template(html_doc, results=results, message=message, title="Weight"), status_code, headers)
