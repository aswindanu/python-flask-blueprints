FROM python:alpine

WORKDIR /app

ENV DEBUG=True
ENV POSTGRES_HOST=8.215.72.152
ENV POSTGRES_PORT=5432
ENV POSTGRES_USERNAME=postgres
ENV POSTGRES_DATABASE=backend_tester
ENV POSTGRES_PASSWORD=Warcr4ft
ENV JWT_SECRET_KEY=jdun28n3932h8dinu2n
ENV DATABASE_URL=postgresql+psycopg2://postgres:password123@8.215.72.152:5432/backend_tester

COPY requirements.txt .
RUN apk --update add libxml2-dev libxslt-dev libffi-dev gcc musl-dev libgcc openssl-dev curl
RUN apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev build-base libpq-dev python3-dev
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . .

RUN sed -i 's/\r$//' start.sh

# CMD ["tail", "-f", "/dev/null"]
CMD ["sh", "./start.sh"]

EXPOSE 5001