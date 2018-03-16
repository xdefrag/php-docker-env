#!/bin/sh

tput clear

tput setaf 5; printf "DEVJS INIT.SH SCRIPT\n\n"

set -e

REPOSITORY=$1

while true
do

  if [ $# == 0 ]
  then
	tput setaf 2; printf "Repository: "
	tput sgr0; read REPOSITORY
  else
    break
  fi

  if [[ "$REPOSITORY" = git@bitbucket.org:* ]]
  then
    break
  else
    tput setaf 1; printf "Use ssh repository link like git@bitbucket.org:devjs_spb/project\n"
  fi

done

printf "\n"

tput setaf 2; printf "Removing api/src... "
tput sgr0
rm -rf ./api/src
tput setaf 2; printf "OK\n\n"

tput setaf 2; printf "Cloning... "
tput sgr0
git clone $REPOSITORY api/src --quiet
tput setaf 2; printf "OK\n\n"

tput setaf 2; printf "Checkout develop... "
tput sgr0
cd api/src
git checkout develop --quiet
git pull --quiet
cd ../..
tput setaf 2; printf "OK\n\n"

tput setaf 5; printf "Repository ready\n\nNow start BUILD.SH\n\n"
