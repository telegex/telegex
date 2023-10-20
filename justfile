dev-env +args:
    docker compose --env-file dev.env -f dev.docker-compose.yml {{args}}
