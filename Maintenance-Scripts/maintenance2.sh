#!/bin/bash

#########################################
# Mac Desktop Maintenance Script 2		#
# Modified : 11th September 2015		#
# Author : Dave Hetherington			#
#########################################

####################################################
# Keep sudo running for the duration of the script #
####################################################

## Checks if the script is being run as admin
if [[ $UID -ne 0 ]]; then echo "Needs to be run as admin - eg. sudo $0" && exit 1; fi

## Keeps the sudo session alive for the duration of the script
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#########################
# Verify Disk Structure #
#########################

## Verify Disk Structure
diskutil verifyVolume /

#####################
# Run the Cron Jobs #
#####################

## Cron jobs
periodic daily weekly monthly

##########################
# Sophos Anti Virus Scan #
##########################

## Sophos Scan
sweep /

############
# Shutdown #
############

## Shutdown the machine
shutdown -h now