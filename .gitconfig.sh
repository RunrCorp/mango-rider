#!/usr/bin/env bash

# Set colors
GREEN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

printf "${GREEN}----${NC}"
echo

# Set .env variables
export $(grep -v '^#' .env | xargs -0)
printf "${GREEN}GOOGLE_MAPS_API_KEY=${GOOGLE_MAPS_API_KEY}${NC}"
echo

printf "${GREEN}----${NC}"
echo

# -- Set custom local .gitconfig --

# Set filter options
git config --local filter.iosgooglemapsapikey.smudge "sed \"s/googleMapsAPIKey = .*/googleMapsAPIKey = \"$GOOGLE_MAPS_API_KEY\"/\""
git config --local filter.iosgooglemapsapikey.clean "sed 's/googleMapsAPIKey = .*/googleMapsAPIKey = GOOGLE_MAPS_API_KEY/'"

printf "${GREEN}Git config was successfully set.${NC}"
echo
printf "${GREEN}----${NC}"

# Unset .env variables
unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs -0)
