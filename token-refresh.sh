#!/bin/bash

# Makes sure this script is run as Su.
if [[ ! -f ./secrets/testFile ]]; then
    echo "Script not executed with administrator privledges. Aborting."
    exit 1
else
    source ./secrets/bskyCreds.env # BlueSky creds
    source ./secrets/errorReporting.env # Error Handling Email Address
fi

# Restrict access to items in secrets folder
chmod 600 ./secrets
chmod 600 ./secrets/*

# Vars
currentTokenFile="./secrets/bskyAccessToken.txt"
refreshTokenFile="./secrets/bskyRefreshToken.txt"
refreshToken=$(cat "$refreshTokenFile")

# Error Handling
erroralert() {
    # Vars on Vars
    local curlError1=$1
    local curlError2=$2
    local thisScript=$(realpath "$0")

    printf "Your script failed because it suuuucks!!.\n\nError: ${curlError1}\nMessage:${curlError2}\n\n------\nNerd Stuff:\nScript: ${thisScript}\n" | sudo -u $myUsername mutt -s 'Script Failed!' -- "${errorRecipient}"
}

# Request Token Swap
curlCall=$(curl -s -X POST "https://bsky.social/xrpc/com.atproto.server.refreshSession" \
    -H "Authorization: Bearer $refreshToken")

# New Token Vars
newAccessToken=$(echo "${curlCall}" | jq -r '.accessJwt')
newRefreshToken=$(echo "${curlCall}" | jq -r '.refreshJwt')
tokenActive=$(echo ${curlCall} | jq -r '.active')

# Error Handling Vars
curlError1=$(echo -n ${curlCall} | jq -r '.error')
curlError2=$(echo -n ${curlCall} | jq -r '.message')

# Error out if no token successfully grabbed in $curlCall
if [[ -z "${newAccessToken}" || "${newAccessToken}" == "null" || "${tokenActive}" != "true" ]]; then
    erroralert "${curlError1}" "${curlError2}"
    exit 1
else
    # Token swap if successful
    echo "${newAccessToken}" > "${currentTokenFile}"
    echo "${newRefreshToken}" > "${refreshTokenFile}"
    echo "Rotation successful."
fi 
