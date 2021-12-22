"""
Common function    
"""
from flask import render_template, make_response

def success(result):
    return {"status":"success", "result":result}, 200, {'Content-Type':'application/json'}

def success_template(html_doc, results):
    headers = {'Content-Type': 'text/html'}
    return make_response(render_template(html_doc, results=results, title="Berat Badan"), 200, headers)

def error_template(html_doc, results, message, status_code):
    headers = {'Content-Type': 'text/html'}
    return make_response(render_template(html_doc, results=results, message=message, title="Berat Badan"), status_code, headers)
