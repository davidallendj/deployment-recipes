#!/bin/bash

# This script is used to test Authelia with Docker Compose within an ochami deployment recipe

CLIENT_ID=smd
CLIENT_SECRET=secret

## Authorize SMD as an OAuth2 client (no dynamic registration yet)
curl "http://127.0.0.1:9091/api/oidc/authorization?grant_type=client_credentials&client_id=smd&client_secret=secret&response_type=token&state=helloworld"

## Get access token
curl -X POST -H "Content-Type: application/x-www-urlencoded" -d 'grant_type=client_credentials&client_id=${CLIENT_ID}&client_secret=${CLIENT_SECRET}'

#TOKEN=$(curl -s -k -u "$CLIENT_ID:$CLIENT_SECRET" \
#    -d grant_type=client_credentials \
#    -d scope=openid \
#    http://127.0.0.1:9091/oauth2/token \
#    )

#ACCESS_TOKEN=$(echo $TOKEN | jq -r '.access_token')
#export ACCESS_TOKEN=$ACCESS_TOKEN

#echo "TOKEN: $TOKEN"
#echo "ACCESS_TOKEN: $ACCESS_TOKEN"

# make a request to the API gateway to SMD
#curl -s -k http://127.0.0.1:3000 -H 'alg: "RS256"' -H '"kid": "$TOKEN"'

# make sure SMD is alive and ready
curl http://127.0.0.1:27779/hsm/v2/service/ready

# make a request directly to SMD
curl http://127.0.0.1:27779/hsm/v2/Inventory/RedfishEndpoints -H "Authorization: BEARER $ACCESS_TOKEN"

# make a request with a bad token
curl http://127.0.0.1:27779/hsm/v2/Inventory/RedfishEndpoints -H "Authorization: BEARER iamabadtoken"
