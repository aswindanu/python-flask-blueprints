set -a
source .env
set +a
ssh admin@$POSTGRES_HOST 'cd cmd/back && ./dc_rm_back.sh && ./dc_pull_back.sh && ./dc_run_back.sh && sudo docker ps -a'