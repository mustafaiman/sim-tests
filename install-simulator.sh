#!/bin/sh
SIMULATOR_HOME=~/hazelcast-simulator-0.11-SNAPSHOT
git clone https://github.com/mustafaiman/hazelcast-simulator.git
cd hazelcast-simulator
git fetch origin
git checkout cache/expiryPerf
mvn clean install -DskipTests
unzip dist/hazelcast-simulator-0.11-SNAPSHOT.zip -d ~/.