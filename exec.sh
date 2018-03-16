#!/bin/sh

tput clear

set -e

docker-compose exec --user www api sh
