#!/bin/bash

#########################################
# Mac Desktop Maintenance Script 1		#
# Modified : 19th June 2020     		#
# Author : Dave Hetherington			#
#########################################

####################################################
# Keep sudo running for the duration of the script #
####################################################

## Checks if the script is being run as admin
if [[ $UID -ne 0 ]]; then echo "Needs to be run as admin - eg. sudo $0" && exit 1; fi

## Keeps the sudo session alive for the duration of the script
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#############################
# Run Apple Software Update #
#############################

softwareupdate -i -a

#####################
# Run Munki Updates #
#####################

## Munki - Check for available updates
/usr/local/munki/managedsoftwareupdate --checkonly

## Sleep for 1 minute 
sleep 60

## Munki - Install available updates
/usr/local/munki/managedsoftwareupdate --installonly

## Sleep for 1 minute 
sleep 60

##########
# Reboot #
##########

shutdown -r now
