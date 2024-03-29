import os
from pathlib import Path
from dotenv import load_dotenv

from sqlalchemy import create_engine
from sqlalchemy.sql import text
from sqlalchemy.orm import sessionmaker, scoped_session

env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path)

DATABASE_URL = "postgresql+psycopg2://{}:{}@{}:{}/{}".format(
    os.getenv("DB_USERNAME"),
    os.getenv("DB_PASSWORD"),
    os.getenv("DB_HOST"),
    os.getenv("DB_PORT"),
    os.getenv("DB_NAME"),
)
print("DATABASE URL", DATABASE_URL)
engine = create_engine(
    DATABASE_URL,
    echo=True
)

Session = scoped_session(sessionmaker(bind=engine))

s = Session()
s.execute(text("""INSERT INTO "public"."weight" ("id", "max", "min", "margin", "date") VALUES
(1, 50, 48, 2, '2018-08-18'),
(2, 51, 50, 1, '2018-08-19'),
(3, 52, 50, 2, '2018-08-20'),
(4, 49, 49, 0, '2018-08-21'),
(5, 50, 49, 1, '2018-08-22');

SELECT setval('weight_id_seq', 6, true);

INSERT INTO "public"."language" ("id", "language", "active") VALUES
('en', 'English', TRUE),
('id', 'Indonesia', TRUE),
('my', 'Malaysia', TRUE),
('sg', 'Singapore', TRUE);

-- password hash is same as 'username'
INSERT INTO "public"."user" ("id", "email", "username", "password", "fullname", "phone", "gender", "active", "ip_address", "created_at", "updated_at") VALUES
(1, 'testone@gmail.com', 'testone', '$2b$12$M1NfYZ9nLl6fHSGa4TDxHOGOEq96TUkTvceQbuCDL31t50lJblXzu', 'Test One', '08123456781', 'M', TRUE, '127.0.0.1', '2018-08-1 00:00:00', '2018-08-19 00:00:00'),
(2, 'testtwo@gmail.com', 'testtwo', '$2b$12$4fGYAq80KmDJo8W/F85bEu8I00NQdyoyUrnsdE0x3csRyAcYEvqoG', 'Test Two', '08123456782', 'F', TRUE, '127.0.0.1', '2018-08-1 00:00:00', '2018-08-19 00:00:00'),
(3, 'testthree@gmail.com', 'testthree', '$2b$12$5LOAsfDLHQMOIgOUw0WvcOSfKwNOGn/3gp9X.TnitvLL7s5/Yd1Ym', 'Test Three', '08123456783', 'M', TRUE, '127.0.0.1', '2018-08-1 00:00:00', '2018-08-19 00:00:00'),
(4, 'testfour@gmail.com', 'testfour', '$2b$12$.46H4YR7CBoKWD0eqPwbUu2Dq7ah7IqEQZdSuGIBH6SIxqcvRroMe', 'Test Four', '08123456784', 'F', TRUE, '127.0.0.1', '2018-08-1 00:00:00', '2018-08-19 00:00:00'),
(5, 'testfive@gmail.com', 'testfive', '$2b$12$srBcyR.uQbH.GryqBWtNKu3FYx90S0UqX6QPthnLQ4qpuyMc8BJgK', 'Test Five', '08123456785', 'M', TRUE, '127.0.0.1', '2018-08-1 00:00:00', '2018-08-19 00:00:00');

SELECT setval('user_id_seq', 6, true);
"""))
s.commit()
