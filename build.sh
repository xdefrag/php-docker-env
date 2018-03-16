#!/bin/sh

tput clear

tput setaf 5; printf "DEVJS BUILD.SH SCRIPT\n\n"

set -e

tput setaf 2; printf "Checking ./api/src... "

if [ -n "$(ls -A api/src 2>/dev/null)" ]
then
  printf "OK\n"
else
  tput setaf 3; printf "\n./api/src is empty\n\n"
  tput setaf 3; printf "Run INIT.SH first\n\n"
  exit
fi


tput setaf 2; printf "\nBuilding docker images... \n\n"
tput sgr0; docker-compose build --force-rm --no-cache
tput setaf 2; printf "OK\n\n"

tput setaf 5; printf "Docker image ready\n\nNow start UP.SH\n\n"
