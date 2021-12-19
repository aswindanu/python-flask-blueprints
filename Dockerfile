FROM python:3.7.5-slim-stretch

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

# RUN flask db init
# RUN flask db migrate
# RUN flask db upgrade

# CMD [ "flask", "run" ]
# CMD [ "start.sh"]

EXPOSE 5000