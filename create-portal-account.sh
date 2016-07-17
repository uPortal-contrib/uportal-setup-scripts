#!/bin/bash
#
# Build out PORTAL_USER local user to host Tomcat and tooling
#

# Source values
. `dirname "$0"`/script.properties

# Created directories
if [ ! -d $PORTAL_DIR ]; then
    mkdir -p $PORTAL_DIR
fi

if [ ! -d $PORTAL_HOME ]; then
    mkdir -p $PORTAL_HOME
fi

# Add group and user
groupadd -f $PORTAL_GROUP
useradd -d $PORTAL_HOME -g $PORTAL_GROUP $PORTAL_USER

# Change ownership to PORTAL_USER
chown -R $PORTAL_USER:$PORTAL_GROUP $PORTAL_DIR
chown -R $PORTAL_USER:$PORTAL_GROUP $PORTAL_HOME
