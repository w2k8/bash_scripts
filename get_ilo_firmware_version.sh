#!/bin/bash

# This script can be used to test if youre HP servers have the correct ilo firmware
# Build a list of items with IP adresses and hostnames.
# Ensure that this script have a correct value with the ilo firmware versions

# Declare colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# cu = current version
#cu4 = ilo4
#cu5 = ilo5

cu4=2.77
cu5=2.35

items="
140.82.121.4,www.github.com
"

for item in $items
do
 HOSTNAME=$(echo $item | cut -d ',' -f2)
 IP=$(echo $item | cut -d ',' -f1)
 fw=$(curl -s -k https://$IP/xmldata?item=all | grep -i fwri)
 if [ ${fw:6:4} = $cu4 ] || [ ${fw:6:4} = $cu5 ] ; then
  echo -e "${GREEN}$HOSTNAME${NC} - $IP - ${GREEN}${fw:6:4}${NC}"
 else
  echo -e "${RED}$HOSTNAME${NC} - $IP - ${RED}${fw:6:4}${NC}"  
 fi
done
