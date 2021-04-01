#!/bin/bash

# This script can be used to test to verify if youre website's use a signed certificate or a self signed certificate.
# Build a list of items with IP adresses and hostnames from youre websites.

declare -A items
var1="DigiCert, Inc."
var2="MyCompany"

# Declare colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

items="
140.82.121.4,www.github.com
"

for item in $items
do
 HOSTNAME=$(echo $item | cut -d ',' -f2)
 IP=$(echo $item | cut -d ',' -f1)
 cert=$(curl --insecure -vvI https://$IP 2>&1 | grep issuer | awk -F "O=" '{print $2}' | awk -F ';' '{print $1}')
 if [ "$cert" = "$var1" ] ; then
  echo -e "${GREEN}$HOSTNAME${NC} - $IP - ${GREEN}${cert}}${NC}"
 else
  echo -e "${RED}$HOSTNAME${NC} - $IP - ${RED}${cert}}${NC}"  
 fi
done
