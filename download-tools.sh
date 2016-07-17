#!/bin/bash
#
# Download Ant, Maven, Tomcat and JDK for uPortal -- current as of 7/15/2016
#

# Source script properties
. `dirname ${0}`/script.properties

# Source versions to use
. `dirname ${0}`/versions.properties

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

# Determine download dir
DL_DIR="$PORTAL_HOME"
if [ -d "$2" ]; then
    DL_DIR="$2"
fi

# Download Ant
if [ ! -f ${DL_DIR}/${ANT_FILE} ]; then
    wget http://archive.apache.org/dist/ant/binaries/${ANT_FILE} -P ${DL_DIR}
fi

# Download Maven
if [ ! -f ${DL_DIR}/${MAVEN_FILE} ]; then
    wget http://archive.apache.org/dist/maven/maven-3/${MAVEN_VER}/binaries/${MAVEN_FILE} -P ${DL_DIR}
fi

# Download JDK
if [ ! -f ${DL_DIR}/${JDK_FILE} ]; then
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/${JDK_LONG_VER}/${JDK_FILE} -P ${DL_DIR}
fi

# Download Tomcat
if [ ! -f ${DL_DIR}/${TOMCAT_FILE} ]; then
    wget http://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_VER}/bin/${TOMCAT_FILE} -P ${DL_DIR}
fi