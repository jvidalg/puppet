#!/bin/bash 

set -euxo pipefail

###############
# Global Vars #
###############

export DNS_ALT_NAMES=puppet.server 
export DOMAIN=modtest


##################
# Ugly Functions #
##################

mkdir_code() {
if [ -d "$(pwd)/volumes/code/environments/production/manifests" ]
then
	echo "Directory for code already exists ... skipping step"
else
	echo "Creating code directory ...."
	mkdir -p $(pwd)/volumes/code/environments/production/manifests
fi
}

cleanup() {
if [ -d "$(pwd)/code/environments/production/manifests" ] || [ -d "$(pwd)/volumes" ]
then
    echo "Removing $(pwd)/volumes ..."
    rm -rf $(pwd)/volumes
    echo "Removing $(pwd)/postgres-custom ..."
    rm -rf $(pwd)/postgres-custom
else
    echo "Directories not present ...."
fi
}

######################
# Ugly Functions End #
######################

if [ $# -eq 0 ] || [ $# -gt 1 ] 
then
    echo "Usage: $0 {install|uninstall|status|restart}"
    exit 1
fi

case "$1" in 
install)
   docker-compose up -d
   mkdir_code 
   sleep 30
   chmod 777 $(pwd)/volumes
   docker-compose ps
   ;;
uninstall)
   docker-compose down
   cleanup
   ;;
restart)
   docker-compose restart
   ;;
status)
   docker-compose ps
   ;;
*)
   echo "Usage: $0 {install|uninstall|status|restart}"
esac

exit 0 
