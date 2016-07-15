#!/bin/bash
#
# Set up tools in local directory

tar xzf apache-tomcat-8.0.35.tar.gz && ln -s apache-tomcat-8.0.35 tomcat
tar xzf apache-ant-1.8.2-bin.tar.gz && ln -s apache-ant-1.8.2 ant
tar xzf apache-maven-3.3.9-bin.tar.gz && ln -s apache-maven-3.3.9 maven
tar xzf jdk-8u92-linux-x64.tar.gz && ln -s jdk1.8.0_92 java
