from app import app
from config.config import DEBUG

if __name__ == "__main__":
    app.run(debug=DEBUG)