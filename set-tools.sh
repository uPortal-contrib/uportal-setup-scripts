#!/bin/bash
#
# Set up tools in local directory

# Source script properties
. `dirname ${0}`/script.properties

# Determine OS
JDK_OS_LIST=" linux-i586 linux-x64 macosx-x64 solaris-sparcv9 solaris-x64 windows-i586 windows-x64 "
JDK_OS=
if [[ "" != "$1" ]] && [[ $JDK_OS_LIST =~ " $1 " ]]; then
    JDK_OS="$1"
else
    echo "Unknown JDK OS (required script parameter). Possible values: "
    echo -e "\t${JDK_OS_LIST[@]}"
    exit 1
fi

# Source versions to use
. `dirname ${0}`/versions.properties

# Source dev properties if found
DEV_PROPS=$(dirname ${0})/dev.properties
if [ -f $DEV_PROPS ]; then
    . $DEV_PROPS
fi

# Handle OSX file ending with .dmg
if [[ "macosx-x64" = "$JDK_OS" ]]; then
    JDK_FILE=jdk-${JDK_VER}-${JDK_OS}.dmg
fi

# Determine download dir
DL_DIR="$DOWNLOAD_DIR"
if [ -d "$2" ]; then
    DL_DIR="$2"
fi

UNTAR="tar xzf"

if [ ! -d "$TOOLS_DIR" ]; then
    mkdir -p $TOOLS_DIR
fi
cd $TOOLS_DIR

# Setup Ant
$UNTAR ${DL_DIR}/${ANT_FILE} && ln -s ${ANT_DIR} ant
# Setup Maven
$UNTAR ${DL_DIR}/${MAVEN_FILE} && ln -s ${MAVEN_DIR} maven

# Setup JDK
if [[ "macosx-x64" = "$JDK_OS" ]]; then
    hdiutil attach "${DL_DIR}/${JDK_FILE}"
    sudo installer -package "${JDK_PKG}" -target /
    hdiutil detach "${JDK_VOL}"
    echo ln -s `/usr/libexec/java_home -R` java
    if [ -f java ]; then
        rm java
    fi
    ln -s `/usr/libexec/java_home -R` java
else
    $UNTAR ${DL_DIR}/${JDK_FILE} && ln -s ${JDK_DIR} java
fi
