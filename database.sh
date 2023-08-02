#!/bin/bash

function create_container() {
    local database_type=$1

    if [ -f "docker-compose.yaml" ]; then
        echo "docker-compose.yaml already exists. To start a different container, first clear the existing one."
        return 1
    fi

    echo "Generating docker-compose.yaml for $database_type..."
    ./tools/scripts/generate-docker-compose.sh "$database_type"
}

function remove_container() {
    local container_id=$1
    if [ -z "$container_id" ]; then
        echo "Usage: ./database.sh -rm container <container_id>"
        return 1
    fi

    if docker inspect "$container_id" &> /dev/null; then
        echo "Removing the container $container_id..."
        docker rm "$container_id"
    else
        echo "Container with ID '$container_id' does not exist."
    fi
}

function start_container() {
    local database_type=$1

    if [ ! -f "docker-compose.yaml" ]; then
        echo "docker-compose.yaml not found. Use '-c' or '--create' option to generate it first."
        return 1
    fi

    echo "Starting $database_type container..."
    docker compose -f "docker-compose.yaml" rm -sf 
    docker compose -f "docker-compose.yaml" up --build
}

function choose_rm() {
    local option=$1

    if [ "$option" == "container" ]; then
        shift
        remove_container "$@"
    elif [ "$option" == "docker-compose" ]; then
        ./tools/scripts/remove-docker-files.sh
    else
        echo "Invalid option. Usage: ./database.sh -rm <container|docker-compose>"
        return 1
    fi
}

chmod +x ./tools/scripts/generate-docker-compose.sh
chmod +x ./tools/scripts/remove-docker-files.sh

if [ -z "$1" ]; then
    echo "Usage: ./database.sh <-c|--create|-run|-rm|--remove>"
    return 1
fi

case "$1" in
    -c | --create)
        shift
        create_container "$@"
        ;;
    -run)
        shift
        start_container "$@"
        ;;
    -rm | --remove)
        shift
        choose_rm "$@"
        ;;
    *)
        echo "Invalid option. Usage: ./database.sh <-c|--create|-run|-rm|--remove>"
        return 1
        ;;
esac
