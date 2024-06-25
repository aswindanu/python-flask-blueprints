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
>        |-config                               configuration, mostly const app
>        |
>        |-docs                                 documentation related
>        |
>        |-infrastructure                       repository data model
>        |       |- cached                      cache handler, mostly redis use
>        |       |- comms                       main VOIP handler
>        |       |- db                          query sql seed
>        |       |- firebase                    repository firebase
>        |       |- model                       model migration orm sqlalchemy
>        |       |- rabbitmq                    message broker handler
>        |       |_ rpc                         rpc call handler
>        |
>        |-internal
>        |       |
>        |       |- logger                      main log handler
>        |       |- protocol                    protocol handler including http, ftp, smtp
>        |       |- service                     business logic base
>        |       |_ util                        utility
>        |
>        |-src                                  backend req/res
>        |       |
>        |       |- blueprints                  versioning blueprint api endpoint
>        |       |- common                      common func handler
>        |       |- error                       error func handler
>        |       |- swagger                     swagger endpoint
>        |       |_ __init__.py                 main src
>        |
>        |-static                               static dir
>        |
>        |-templates                            frontend template handler
>        |
>        |- .env
>        |- app.py                              main app
>        |- route.py                            router app
>        |- wsgi.py                             connection
>        |_ ....


Manually delete ENUM :

        select n.nspname as enum_schema,  
        t.typname as enum_name,  
        e.enumlabel as enum_value
        from pg_type t 
        join pg_enum e on t.oid = e.enumtypid  
        join pg_catalog.pg_namespace n ON n.oid = t.typnamespace;

then drop it
        
        DROP TYPE <enum_name>;

then create new one

        ALTER TYPE <enum_name> ADD VALUE 'new_value';