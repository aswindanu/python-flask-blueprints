FROM python:3.7.5-slim-stretch

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

RUN sed -i 's/\r$//' start.sh

EXPOSE 5000