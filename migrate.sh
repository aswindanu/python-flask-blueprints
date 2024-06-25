set -a
source .env
set +a
flask db migrate
flask db upgrade