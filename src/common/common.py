"""
Common function    
"""
from flask import render_template, make_response
from internal.util.translate import translate


def response(result, code=200):
    if code != 200:
        return {translate(result)}, code, {'Content-Type':'application/json'}
    return {"status":"success", "result": translate(result)}, code, {'Content-Type':'application/json'}

def success_template(html_doc, results):
    headers = {'Content-Type': 'text/html'}
    return make_response(render_template(html_doc, results=results, title="Weight"), 200, headers)

def error_template(html_doc, results, message, status_code):
    headers = {'Content-Type': 'text/html'}
    return make_response(render_template(html_doc, results=results, message=message, title="Weight"), status_code, headers)
