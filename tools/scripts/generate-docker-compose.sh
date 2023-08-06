#!/bin/bash

function generate_dockerfile() {
    local database_type=$1

    local dockerfile_path="./tools/Dockerfile.$database_type"

    if [ "$database_type" == "mongo" ]; then
        cat > "$dockerfile_path" <<EOL
FROM mongo:latest

ENV MONGO_PORT 27017

EXPOSE \$MONGO_PORT
EOL
    elif [ "$database_type" == "postgres" ]; then
        cat > "$dockerfile_path" <<EOL
FROM postgres:14

COPY tools/database/fixtures /database/fixtures
COPY tools/database /tmp/database
RUN find /tmp/database -type f -exec cp {} /docker-entrypoint-initdb.d/ \;

RUN rm -r /tmp/database

EXPOSE 5432
EOL
    else
        echo "Invalid option. Use 'mongo' or 'postgres'."
        return 1
    fi
}

function generate_compose_file() {
    local database_type=$1
    generate_dockerfile "$database_type"

    cat > docker-compose.yaml <<EOL
version: '3'
services:
  $database_type:
    container_name: default_container
    build:
      context: .
      dockerfile: ./tools/Dockerfile.$database_type
EOL
}

if [ -z "$1" ]; then
    echo "Usage: ./database.sh <-c|--create> <mongo|postgres>"
    exit 1
fi

generate_compose_file "$1"
