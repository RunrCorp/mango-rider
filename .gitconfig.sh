#!/usr/bin/env bash

# Set colors
GREEN='\033[1;32m'
CYAN='\033[1;36m'
RED='\033[1;31m'
NC='\033[0m'

printf "${GREEN}----${NC}"
echo
# Set .env variables
export $(grep -v '^#' .env | xargs -0)
if [ -z ${GOOGLE_MAPS_API_KEY+x} ] || [ -z ${FIREBASE_IOS+x}  ]
then
    printf "${GREEN}----${NC}"
    echo

    printf "${RED}ERROR: Please set up .env file before running.${NC}"
    echo

    printf "${CYAN}Stopping ...${NC}"
    echo

    unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs -0)

    exit

else 
    printf "${CYAN}.env file found!${NC}"
    echo

    printf "${GREEN}----${NC}"
    echo

fi

printf "${GREEN}GOOGLE_MAPS_API_KEY=${GOOGLE_MAPS_API_KEY}${NC}"
echo

printf "${GREEN}FIREBASE_IOS=${FIREBASE_IOS}${NC}"
echo

printf "${GREEN}----${NC}"
echo

# Inserts API keys into file
sed -i '' 's/googleMapsAPIKey = .*/googleMapsAPIKey = "'${GOOGLE_MAPS_API_KEY}'"/' 'ios/Runner/AppDelegate.swift'

sed -i '' 's~<!--iosfirebaseios--> <string>.*~<!--iosfirebaseios--> <string>'${FIREBASE_IOS}'</string>~' 'ios/Runner/GoogleService-Info.plist'

# -- Set custom local .gitconfig --

# Set filter options
git config --local filter.iosgooglemapsapikey.smudge "sed 's/googleMapsAPIKey = .*/googleMapsAPIKey = \"$GOOGLE_MAPS_API_KEY\"/'"
git config --local filter.iosgooglemapsapikey.clean "sed 's/googleMapsAPIKey = .*/googleMapsAPIKey = GOOGLE_MAPS_API_KEY/'"

git config --local filter.iosfirebaseios.smudge "sed 's~<!--iosfirebaseios--> <string>.*~<!--iosfirebaseios--> <string>$FIREBASE_IOS</string>~'"
git config --local filter.iosfirebaseios.clean "sed 's~<!--iosfirebaseios--> <string>.*~<!--iosfirebaseios--> <string>FIREBASE_IOS</string>~'"

printf "${GREEN}Git config was successfully set.${NC}"
echo
printf "${GREEN}----${NC}"

# Unset .env variables
unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs -0)

exit
