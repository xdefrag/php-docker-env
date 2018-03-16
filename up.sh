#!/bin/sh

tput clear

set -e

docker-compose down &>/dev/null
docker-compose up -d
docker-compose logs -f
