#!/bin/bash

function generate_compose_file() {
    local database_type=$1
    if [ "$database_type" == "mongo" ]; then
        cat > docker-compose.yaml <<EOL
version: '3'
services:
  mongo:
    container_name: default_container
    build:
      context: .
      dockerfile: tools/Dockerfile.mongo
    ports:
      - "27017:27017"
EOL
    elif [ "$database_type" == "postgres" ]; then
        cat > docker-compose.yaml <<EOL
version: '3'
services:
  database:
    container_name: default_container
    build:
      context: .
      dockerfile: tools/Dockerfile.postgres
    env_file:
      - ./tools/.env
    ports:
      - "5432:5432"
EOL
    else
        echo "Invalid option. Use 'mongo' or 'postgres'."
        return 1
    fi
}

if [ -z "$1" ]; then
    echo "Usage: ./database.sh <-c|--create> <mongo|postgres>"
    exit 1
fi

generate_compose_file "$1"
