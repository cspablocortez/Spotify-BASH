#!/bin/bash

# GET THESE VALUES FROM SPOTIFY DEVELOPER DASHBOARD
CLIENT_ID=""
CLIENT_SECRET=""

access_refresh=$(curl -X POST "https://accounts.spotify.com/api/token" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "grant_type=client_credentials&client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET")

access_token=$(echo "$access_refresh" | jq -r '.access_token')

echo -n "$access_token" > "./access_token"