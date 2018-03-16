#!/bin/sh

set -e

docker-compose exec --user www api sh -c "./vendor/bin/phpunit"
