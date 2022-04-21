export FLASK_ENV=development

flask db init
flask db migrate
flask db upgrade

python model/seed.py

flask run -h 0.0.0.0