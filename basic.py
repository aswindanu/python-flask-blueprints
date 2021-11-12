# -*- coding: utf-8 -*-

import functools

from flask import (
    Blueprint,  
    redirect, 
    render_template, 
    request, 
    url_for, jsonify
)
from werkzeug.exceptions import abort

from .model.db_model import (Myfamily, db)


bp = Blueprint('manage_family', __name__, url_prefix='')

@bp.route('/all', methods=('GET','POST'))
def all_family():
    all_family = Myfamily.query.all()
    return render_template('base.html', family=all_family, title="Families")

@bp.route('/<int:fam_id>/edit', methods=('GET','POST'))
def edit_person(fam_id):
    person = get_single_person(fam_id)
    all_family = Myfamily.query.filter(Myfamily.id != fam_id).all()
    if person == None:
        abort(404,'Person doesn\'t exist')

    if request.method == 'POST':
        name = request.form['fname']
        kelamin = request.form['kelamin']
        parent_id = request.form['select_parent'] 
        
        person.nama = name
        person.kelamin = kelamin
        person.orang_tua_id = parent_id
        db.session.commit()
        return redirect(url_for('manage_family.all_family'))
    else:
        return render_template('edit family.html', person = person, family =all_family )
    
@bp.route('/<int:fam_id>/delete')
def delete_person(fam_id):
	f = get_single_person(fam_id)
	if f == None:
		abort(404,'Person doesn\'t exist')

	db.session.delete(f)
	db.session.commit()
	return redirect(url_for('manage_family.all_family'))

def get_single_person(id):
    f = Myfamily.query.filter_by(id=id).one_or_none()
    return f

@bp.route('/add',  methods=('GET', 'POST'))
def add_family():
    if request.method == 'POST':
        name = request.form['fname']
        kelamin = request.form['kelamin']
        parent_id = request.form['select_parent'] 
        
        if parent_id == None:
            new_fam = Myfamily( nama = name, kelamin = kelamin)
        else:
            new_fam = Myfamily( nama = name, kelamin = kelamin, orang_tua_id = parent_id)
        db.session.add(new_fam)
        db.session.commit()
        return redirect(url_for('manage_family.all_family'))

    else:
        all_family = Myfamily.query.all()
        return render_template('add family.html', family = all_family)

@bp.route('/<int:person_id>/get_children')
def visual(person_id):

    fams = Myfamily.query.filter(Myfamily.orang_tua_id == person_id)
    return jsonify(Children = [i.serialize for i in fams])

@bp.route('/<int:person_id>/info')
def info(person_id):
    p = Myfamily.query.filter(Myfamily.id == person_id).one()
    return jsonify(Person = p.serialize)