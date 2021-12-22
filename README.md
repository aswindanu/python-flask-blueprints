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

2. Go to project dir:
    ```cd flask_simple```

3. configure your env in `.env` file (copy from .env.sample)
    ```cp .env.sample .env```

4. Build docker-compose:
    ```docker-compose up -d --build db```
    ```docker-compose up -d --build api```

5. Run the program from website with url `localhost:5000`
