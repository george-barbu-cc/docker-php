#!/bin/bash

source ./.env
CONTAINER_NAME="${APP_NAME}_web"

docker exec -it "${CONTAINER_NAME}" bash
