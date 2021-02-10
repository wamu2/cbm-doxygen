#!/bin/sh
#
set -o pipefail
set -ex

# define versions, path, repositories
export PLANTUML_PATH=/opt/plantuml
export PLANTUML_VERS=1.2020.19
export DOXYGEN_VERS=1.9.1-r0
export DOXYGEN_REPO=http://dl-cdn.alpinelinux.org/alpine/edge/main

# get apk repos
apk add --no-cache openjdk11-jre
apk add --no-cache curl
apk add --no-cache graphviz
apk add --no-cache fontconfig font-noto

# get plantuml
mkdir -p $PLANTUML_PATH
curl -sS -L https://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VERS}.jar/download -o ${PLANTUML_PATH}/plantuml.jar

# setup ubuntu/debian compatible plantuml path
mkdir -p /usr/share/plantuml
(cd /usr/share/plantuml; ln -s ${PLANTUML_PATH}/plantuml.jar)

# get doxygen
apk add --no-cache doxygen=${DOXYGEN_VERS} --repository ${DOXYGEN_REPO}

# test plantuml
cat <<EOF > test.puml
@startuml
Bob->Alice : hello
@enduml
EOF

java -jar ${PLANTUML_PATH}/plantuml.jar -tsvg *.puml
ls -al

# drop tmp files
cd ..
rm -rf /tmp/*
