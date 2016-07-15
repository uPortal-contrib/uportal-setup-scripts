#!/bin/bash

# Add environment entries to Bash startup scripts for Java tools

# Optional: parent directory to tools
PARENT_DIR="/opt/uportal"
if [ -d "$1" ]; then
    PARENT_DIR="$1"
fi
echo $PARENT_DIR

echo "Checking for Bash env properties ..."
echo
echo -e "\t if vars found, assume they are in PATH. Manual PATH update may be required"
echo
echo

if [ ! -f ~/.bashrc ]; then
    echo "Creating ~/.bashrc"
    touch ~/.bashrc
fi

JAVA_HOME_GREP=`grep "JAVA_HOME=" ~/.bashrc`
if [ "" = "$JAVA_HOME_GREP" ]; then
    echo "JAVA_HOME not found. Adding to ~/.bashrc"
    echo "export JAVA_HOME=$PARENT_DIR/java" >> ~/.bashrc
else
    echo $JAVA_HOME_GREP " found."
fi

ANT_HOME_GREP=`grep "ANT_HOME=" ~/.bashrc`
if [ "" = "$ANT_HOME_GREP" ]; then
    echo "ANT_HOME not found. Adding to ~/.bashrc"
    echo "export ANT_HOME=$PARENT_DIR/ant" >> ~/.bashrc
else
    echo $ANT_HOME_GREP " found."
fi

M2_HOME_GREP=`grep "M2_HOME=" ~/.bashrc`
if [ "" = "$M2_HOME_GREP" ]; then
    echo "M2_HOME not found. Adding to ~/.bashrc"
    echo "export M2_HOME=$PARENT_DIR/maven" >> ~/.bashrc
else
    echo $M2_HOME_GREP " found."
fi

TOMCAT_HOME_GREP=`grep "TOMCAT_HOME=" ~/.bashrc`
if [ "" = "$TOMCAT_HOME_GREP" ]; then
    echo "TOMCAT_HOME not found. Adding to ~/.bashrc"
    echo "export TOMCAT_HOME=$PARENT_DIR/tomcat" >> ~/.bashrc
else
    echo $TOMCAT_HOME_GREP " found."
fi

## build bin dirs for PATH
BINS=""
BIN_DIRS=( "\$JAVA_HOME/bin" "\$M2_HOME/bin" "\$ANT_HOME/bin" )
for BIN_DIR in ${BIN_DIRS[@]}; do
    BIN_FOUND=$(grep "PATH=.*$BIN_DIR" ~/.bashrc)
    if [ "" = "$BIN_FOUND" ]; then
        if [ "" != "${BINS}" ]; then
            BINS="${BINS}:${BIN_DIR}"
        else
            BINS="${BIN_DIR}"
        fi
    fi
done

echo $BINS

if [ "" != "$BINS" ]; then
    echo "export PATH=$BINS:\$PATH" >> ~/.bashrc
fi

echo
echo -e "\t Adding aliases to start and stop tomcat"
TCSTOP_EXISTS=$(alias | grep tcstop)
if [ "" = "$TCSTOP_EXITS" ]; then
    echo "adding tcstop ..."
    echo "alias tcstop=\$TOMCAT_HOME/bin/shutdown.sh" >> ~/.bashrc
fi
TCSTART_EXISTS=$(alias | grep tcstart)
if [ "" = "$TCSTART_EXITS" ]; then
    echo "adding tcstart ..."
    echo "alias tcstart=\$TOMCAT_HOME/bin/startup.sh" >> ~/.bashrc
fi

echo
echo -e "\t ~/.bashrc now looks like:"
cat ~/.bashrc


echo
echo -e "\t Checking ~/.bash_profile ..."
echo

if [ -f ~/.bash_profile ]; then
    echo -e "\t ~/.bash_profile found."
    SOURCE_BASHRC=$(grep ". ~/.bashrc" ~/.bash_profile)
    if [ "" = "$SOURCE_BASHRC" ]; then
        echo -e "\t Adding ~/.bashrc sourcing ..."
        echo ". ~/.bashrc" >> ~/.bash_profile
    else
        echo -e "\t ~/.bashrc already sourced"
    fi
else
    echo -e "\t Creating ~/.bash_profile"
        echo ". ~/.bashrc" > ~/.bash_profile
fi

echo
echo "Done."
echo
