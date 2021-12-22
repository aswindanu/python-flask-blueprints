import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session


engine = create_engine(
    os.environ["DATABASE_URL"],
    echo=True
)

Session = scoped_session(sessionmaker(bind=engine))

s = Session()
s.execute(
"""
INSERT INTO "public"."berat_badan" ("id", "max", "min", "perbedaan", "tanggal") VALUES
(1, 50, 48, 2, '2018-08-18'),
(2, 51, 50, 1, '2018-08-19'),
(3, 52, 50, 2, '2018-08-20'),
(4, 49, 49, 0, '2018-08-21'),
(5, 50, 49, 1, '2018-08-22');

SELECT setval('berat_badan_id_seq', 6, true);
"""
)
s.commit()
