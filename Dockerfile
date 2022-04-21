FROM python:alpine

WORKDIR /app

COPY requirements.txt .
RUN apk --update add libxml2-dev libxslt-dev libffi-dev gcc musl-dev libgcc openssl-dev curl
RUN apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev build-base libpq-dev python3-dev
RUN pip install -r requirements.txt

COPY . .

RUN sed -i 's/\r$//' start.sh

EXPOSE 5000