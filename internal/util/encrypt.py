import bcrypt


def hash_password(password):
    password = password.encode("utf-8")
    salt = bcrypt.gensalt()
    return bcrypt.hashpw(password, salt).decode("utf-8")

def validate_password(password, hashed):
    password = password.encode("utf-8")
    hashed = hashed.encode("utf-8")
    return bcrypt.checkpw(password, hashed)
