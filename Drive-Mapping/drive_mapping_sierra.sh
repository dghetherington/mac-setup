#!/bin/bash

#####################################
# Mac Domain Drive Mapping Script
# Modified : 19th June 2020
# Author : Dave Hetherington
#####################################

# Works on macOS 10.12 and above

WHOAMI=`whoami`
GROUP=`id -p "$WHOAMI"`
FILESERVER="fileserverFQDN" # Change this to the FQDN of your file server

# Local Folders to Map Network shares to in macOS 10.15
ADMIN=~/Filestore/Administration
RESEARCH=~/Filestore/Research
PERSONAL=~/Filestore/"$WHOAMI"

## Create Filestore Directory if it doesn't exist

if [ -d $FILESTORE ]; then
:
else
mkdir ~/Filestore
sleep 1
fi

## Mount the Personal drive - Replace DOMAIN with your Active Directory Domain Name
if [[ $GROUP == *"DOMAIN\Personal"* ]]; then
mkdir "$PERSONAL"
mount -t smbfs //$WHOAMI@$FILESERVER/Personal/$WHOAMI $PERSONAL
else
sleep 1
fi

## Mount the Admin drive - Replace DOMAIN with your Active Directory Domain Name

if [[ $GROUP == *"DOMAIN\Administration"* ]]; then
mkdir "$ADMIN"
mount -t smbfs //$WHOAMI@$FILESERVER/Administration $ADMIN
else
sleep 1
fi

