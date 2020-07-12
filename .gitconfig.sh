#!/usr/bin/env bash

# Set colors
GREEN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

# Set .env variables
(set -a && . .env && ...)
GOOGLE_MAPS_API_KEY = $GOOGLE_MAPS_API_KEY
printf "${GOOGLE_MAPS_API_KEY}"

printf "${GREEN}----${NC}"

echo

# Set user email
read -p "Set your email adress: " email
git config --local user.email $email
printf "${CYAN}User email was set.${NC}"

echo
echo

# Set user name
read -p "Set your user name: " name
git config --local user.name $name
printf "${CYAN}User name was set.${NC}"

echo
echo

# Connect .gitconfig
# git config --local include.path '../.gitconfig'

git config --global filter.iosgooglemapsapikey.smudge 'sed "s/googleMapsAPIKey = .*/googleMapsAPIKey = "AJFKLDJSFEIJKDL:FJKALF:JKLD"/"'
git config --global filter.iosgooglemapsapikey.clean 'sed "s/googleMapsAPIKey = .*/googleMapsAPIKey = "GOOGLE_MAPS_API_KEY"/"'

printf "${GREEN}Git config was successfully set.${NC}"
echo
printf "${GREEN}----${NC}"