#!/bin/bash
#
# Install basic commands needed for these scripts
#

YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)
PACKAGE_NAMES="wget git"

if [[ ! -z $YUM_CMD ]]; then
    yum install $PACKAGE_NAMES
 elif [[ ! -z $APT_GET_CMD ]]; then
    apt-get install $PACKAGE_NAMES
 else
    echo "Could not find 'yum' or 'apt-get'"
    exit 1;
 fi
