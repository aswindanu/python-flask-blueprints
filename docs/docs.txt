How to Start Project

- Clone this project: git clone https://github.com/aswindanu/python-flask-simple.git flask_simple

- Go to project dir: cd flask_simple

- configure your env in .env file (copy from .env.sample) cp .env.sample .env

- Build docker-compose: 

        docker-compose up -d --build db 
        docker-compose up -d --build api

- Run the program from website with url localhost:5000
