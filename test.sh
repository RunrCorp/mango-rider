# Set .env variables
(set -a && . .env && ...)
GOOGLE_MAPS_API_KEY = $GOOGLE_MAPS_API_KEY
printf "${GOOGLE_MAPS_API_KEY}"