"""# BE - Berat #

NOTE:Sebelum memulai test, persiapkan

 - Development Tools dan Bahasa Pemograman favorit kalian.
 - Git
 - Waktu luang (1-2 Jam)

Buatlah sebuah program CRUD yang mencatat berat badan.

Program harus mempunyai:
- Sebuah laman index yang menampilkan berat badan per hari.
   - Perbedeaan berat badan di dapat dengan cara `max - min`.
   - Data harus di urut secara menurun.
   - Data rata-rata.
- Sebuah laman detail yang menampilkan berat badan pada hari tertentu.
- Sebuah laman create & edit untuk membuat / update data berat badan.
   - Formnya harus mempunyai
      - Tanggal
      - Berat Max
      - Berat Min

> Sebagai contoh, laman index akan menampilkan tabel seperti:

Tanggal|Max|Min|Perbedeaan
--- | --- | --- | ---
2018-08-22 |50 |49 |1
2018-08-21 |49 |49 |0
2018-08-20 |52 |50 |2
2018-08-19 |51 |50 |1
2018-08-18 |50 |48 |2
**Rata-rata**|**50.4** |**49.2** |**1.2**

> Sebagai contoh, laman show akan menampilkan data seperti:

Tanggal|2018-08-18
--- | ---
Max |52
Min |50
Perbedeaan |2

IMPORTANT: Penilaian

__Nilai akan diberikan berdasarkan__

- Code quality & readability
   - Apakah engineer lain dapat mengerti code anda?
- Software design
   - Apakah pengunaan `class`,`object`,`function` sudah maksimal?
- Engineering best practices
   - Apakah sudah mengikuti pola arsitektur dengan benar, seperti MVC atau SOLID
- Automated tests
   - e2e, integration, unit
- ~~Fancy UI~~

Program harap di upload ke PRIVATE GitHub repository dan tambahkan/invite fandywie sebagai Collaborator.
Apabila ada pertanyaan dapat menghubungi tech.career@sirclo.co.id 
"""

import os
import sys
from json import loads
from pathlib import Path
from dotenv import load_dotenv

from flask import Flask
from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy

from util.common import success_template

# Load .env Python
env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path)

# Flask APP
app = Flask(__name__)

DEBUG = loads(os.getenv("DEBUG").lower())
app.config['APP_DEBUG'] = DEBUG
app.config['PROPAGATE_EXCEPTIONS'] = DEBUG

# DATABASE
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql+psycopg2://{}:{}@{}:{}/{}".format(
    os.getenv("DATABASE_USERNAME") or os.getenv("POSTGRES_USERNAME"),
    os.getenv("DATABASE_PASSWORD") or os.getenv("POSTGRES_PASSWORD"),
    os.getenv("DATABASE_HOST") or os.getenv("POSTGRES_HOST"),
    os.getenv("DATABASE_PORT") or os.getenv("POSTGRES_PORT"),
    os.getenv("DATABASE_DATABASE") or os.getenv("POSTGRES_DATABASE"),
)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
migrate = Migrate(app, db)

@app.route('/')
def hello():
   return success_template('home.html', [])

from blueprints.index import bp_index
from blueprints.detail import bp_detail
from blueprints.crud import bp_crud

app.register_blueprint(bp_index)
app.register_blueprint(bp_detail)
app.register_blueprint(bp_crud)

db.create_all()
