#!/bin/bash

# IBM Confidential
# OCO Source Materials
# 5725-Y50
# (C) Copyright IBM Corp. 2015
# The source code for this program is not published or
# otherwise divested of its trade secrets, irrespective
# of what has been deposited with the U.S. Copyright Office.

set -e
set -x

SOURCE_FOLDER=$(pwd)
TARGET_FOLDER=./target
BUILD_FOLDER=./build

if [ ! -d "${TARGET_FOLDER}" ]; then
    mkdir -v "${TARGET_FOLDER}"
fi
if [ ! -d "${BUILD_FOLDER}" ]; then
    mkdir -v "${BUILD_FOLDER}"
    else
      rm -rf ${BUILD_FOLDER}/*
fi

function command_exists() {
	type "$1" &> /dev/null;
}

############################################################
# Download required tarball for toree 
############################################################

TOREE_SHA=6be462faa13095a51f83f479a468630438e0a437
curl -L -s https://github.com/apache/incubator-toree/archive/$TOREE_SHA.zip -o ${BUILD_FOLDER}/toree.zip
unzip ${BUILD_FOLDER}/toree.zip -d ${BUILD_FOLDER}
rm -rf ${BUILD_FOLDER}/toree.zip
mv ${BUILD_FOLDER}/incubator-toree-$TOREE_SHA  ${BUILD_FOLDER}/toree
cd "${BUILD_FOLDER}/toree/"

#make dist

version=$(grep -wm 3 spark.version  ${SOURCE_FOLDER}/deploy.pom.xml | grep -v xml | sed -e 's;<spark.version>;;g'|sed -e 's;</spark.version>;;g'|sed -e 's; ;;g' )
make clean release  APACHE_SPARK_VERSION=$version

#mv target/scala-2.11/toree*.jar toree-assembly-1.0.0.jar


echo -e "\nSuccess!"
exit 0
