# Simple python FLASK

this project using this kind of library:
* API Framework : https://www.fullstackpython.com/flask.html
* ORM : https://flask-sqlalchemy.palletsprojects.com/en/2.x/
* Configs : https://pypi.org/project/python-dotenv/
* Unit Test : https://docs.pytest.org/en/latest/
* Logging : https://docs.python.org/2/library/logging.html

#### How to Start Project
1. Clone this project:
    ```git clone https://github.com/aswindanu/python-flask-simple.git flask_simple```

2. Create env:
    ```python -m venv env```

3. Activate ENV (Linux/OSX):
    ```source env/bin/activate```

4. GO to project dir:
    ```cd flask_simple```

5. install requirements:
    ```pip install -r requirements.txt```

6. configure your env in `.env` file

    - DEBUG=
    - DATABASE_URL=

7. configure your env for `FLASK_APP` & `FLASK_ENV`

    - export FLASK_APP="app"
    - export FLASK_ENV="development" (debug)

8. Create the database `myfamily` 

9. Import data from `db/db.sql`

10. run the program:
    ```flask run```

#### Update requirements (virtualenv)
```pip freeze -l > requirements.txt```

#### Reset migration db
delete migrations, then use ```flask db init```
