#!/bin/bash

# This script can be used to test if youre HP servers have the correct idrac firmware
# Build a list of items with IP adresses and hostnames.
# Ensure that this script have a correct value with the idrac firmware versions

# Declare colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# cu = current version
#cu = idrac version

# 2.75.02 !> 2.75.100.75
cu='"2.75.02"'

items="
140.82.121.4,www.github.com
"

for item in $items
do
 HOSTNAME=$(echo $item | cut -d ',' -f2)
 IP=$(echo $item | cut -d ',' -f1)
 fw=$(curl -s -k https://$IP/session?aimGetProp=fwVersion | jq .aimGetProp.fwVersion)
 if [ ${fw:6:4} = $cu4 ] || [ ${fw:6:4} = $cu5 ] ; then
  echo -e "${GREEN}$HOSTNAME${NC} - $IP - ${GREEN}iDrac firmware version: $fw ${NC}"
 else 
  echo -e "${RED}$HOSTNAME${NC} - $IP - ${RED}iDrac firmware version: $fw ${NC}"  
 fi
done
