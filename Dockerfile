FROM python:alpine

WORKDIR /app

COPY . .

RUN \
    # apk --update add libxml2-dev libxslt-dev libffi-dev gcc musl-dev libgcc openssl-dev curl && \
    # apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev build-base libpq-dev python3-dev && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install flask-jwt-extended --upgrade

RUN rm -rf migrations
RUN flask db init
RUN flask db migrate
RUN flask db upgrade

RUN python model/seed.py

RUN sed -i 's/\r$//' start.sh
CMD ["sh", "./start.sh"]
# CMD ["tail", "-f", "/dev/null"]

EXPOSE 5001