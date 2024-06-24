How to Start Project

- Clone this project: git clone https://github.com/aswindanu/python-flask-simple.git flask_simple

- Go to project dir: cd flask_simple

- configure your env in .env file (copy from .env.sample) cp .env.sample .env

- Build docker-compose: 

        docker-compose up -d --build db 
        docker-compose up -d --build api

- Run the program from website with url localhost:5000





Architecture :

python-flask-blueprints
>        |
>        |
>        |-.github                              github actions CI/CD automation
>        |
>        |-config                               configuration const app
>        |
>        |-docs                                 documentation related
>        |
>        |-infrastructure                       repository data model
>        |
>        |-internal                             utility base app
>        |
>        |-src                                  backend req/res api
>        |
>        |-static                               static dir
>        |
>        |-templates                            frontend template
>        |
>        |- .env
>        |- app.py                              main app
>        |- route.py                            router app
>        |- wsgi.py                             connection
>        |_ ....