export FLASK_ENV=development

# handle deprecated
pip install flask-jwt-extended --upgrade

flask db init
flask db migrate
flask db upgrade

python model/seed.py

flask run -h 0.0.0.0