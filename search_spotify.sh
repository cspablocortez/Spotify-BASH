#!/bin/bash

# Set color variables
GREEN='\033[0;32m'
NC='\033[0m' # No Color

access_token=$(cat access_token)

read -p "Search Artist: " ARTIST_NAME
ENCODED_ARTIST_NAME=${ARTIST_NAME// /%20}

search_result=$(curl -s --request GET \
  --url "https://api.spotify.com/v1/search?q=$ENCODED_ARTIST_NAME&type=artist" \
  --header "Authorization: Bearer $access_token")

echo "-------------------------"
artist_name_result=$(echo "$search_result" | jq -r '.artists.items[0].name')
artist_id=$(echo "$search_result" | jq -r '.artists.items[0].id')
url=$(echo "$search_result" | jq -r '.artists.items[0].external_urls.spotify')
genres=$(echo "$search_result" | jq -r '.artists.items[0].genres')

echo -e "${GREEN}Artist Name:${NC} $artist_name_result" 
echo -e "${GREEN}Artist ID:${NC} $artist_id" 
echo -e "${GREEN}URL:${NC} $url"
echo -e "${GREEN}Genre:${NC} $genres"
echo "-------------------------"

top_tracks_result=$(curl -s --request GET \
  --url "https://api.spotify.com/v1/artists/$artist_id/top-tracks?country=US" \
  --header "Authorization: Bearer $access_token")

echo -e "${GREEN}New file saved:"
echo "$search_result" > "json/$ENCODED_ARTIST_NAME.json"
echo -e "$ENCODED_ARTIST_NAME.json${NC}"
echo "-------------------------"

top_tracks=$(echo "$top_tracks_result" | jq -r '.tracks[].name')

echo "Top Tracks:"
echo "$top_tracks"
