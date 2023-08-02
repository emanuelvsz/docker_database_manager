#!/bin/bash

function remove_compose_file() {
    if [ -f "docker-compose.yaml" ]; then
        echo "Removing docker-compose.yaml..."
        rm "docker-compose.yaml"
    else
        echo "docker-compose.yaml does not exist."
    fi
}

remove_compose_file