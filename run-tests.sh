#!/bin/sh
SIMULATOR_HOME=~/hazelcast-simulator-0.11-SNAPSHOT
MEMBERS=2
CLIENTS=1
DURATION=2m

memberHeapSZ=1G
clientHeapSZ=512M

partitions=271
monitorSec=30

gcArgs="-verbose:gc -Xloggc:verbosegc.log"
gcArgs="${gcArgs} -XX:+PrintGCTimeStamps -XX:+PrintGCDetails -XX:+PrintTenuringDistribution -XX:+PrintGCApplicationStoppedTime -XX:+PrintGCApplicationConcurrentTime"

memberJvmArgs="-Dhazelcast.partition.count=${partitions}"
memberJvmArgs="${memberJvmArgs} -Dhazelcast.health.monitoring.level=NOISY -Dhazelcast.health.monitoring.delay.seconds=${monitorSec}"
memberJvmArgs="${memberJvmArgs} -Xmx${memberHeapSZ} -XX:+HeapDumpOnOutOfMemoryError"
memberJvmArgs="${memberJvmArgs} ${gcArgs}"

clientJvmArgs="-Xmx${clientHeapSZ} -XX:+HeapDumpOnOutOfMemoryError"
clientJvmArgs="${clientJvmArgs} ${gcArgs}"

$SIMULATOR_HOME/bin/coordinator cache.no.expiration.properties --members $MEMBERS --clients $CLIENTS --duration $DURATION --sessionId m${MEMBERS}-c${CLIENTS}-cache-no-expiration --memberArgs "${memberArgs}" --clientArgs "${clientArgs}"
$SIMULATOR_HOME/bin/coordinator --clean
$SIMULATOR_HOME/bin/coordinator cache.expiration.properties --members $MEMBERS --clients $CLIENTS --duration $DURATION --sessionId m${MEMBERS}-c${CLIENTS}-cache-expiration --memberArgs "${memberArgs}" --clientArgs "${clientArgs}"
$SIMULATOR_HOME/bin/coordinator --clean
$SIMULATOR_HOME/bin/coordinator cache.expiration.properties --members $MEMBERS --clients $CLIENTS --duration $DURATION --sessionId m${MEMBERS}-c${CLIENTS}-cache-expiration-delay-task --memberArgs "-Dhazelcast.internal.cache.expiration.task.period.seconds=300 ${memberArgs}" --clientArgs "${clientArgs}"
$SIMULATOR_HOME/bin/coordinator --clean
$SIMULATOR_HOME/bin/coordinator cache.no.expiration.properties --members $MEMBERS --clients $CLIENTS --duration $DURATION --sessionId m${MEMBERS}-c${CLIENTS}-cache-no-expiration-100 --memberArgs "-Dhazelcast.internal.cache.expiration.cleanup.percentage=100 ${memberArgs}" --clientArgs "${clientArgs}"
$SIMULATOR_HOME/bin/coordinator --clean
$SIMULATOR_HOME/bin/coordinator cache.expiration.properties --members $MEMBERS --clients $CLIENTS --duration $DURATION --sessionId m${MEMBERS}-c${CLIENTS}-cache-expiration-100 --memberArgs "-Dhazelcast.internal.cache.expiration.cleanup.percentage=100 ${memberArgs}" --clientArgs "${clientArgs}"
$SIMULATOR_HOME/bin/coordinator --clean
$SIMULATOR_HOME/bin/coordinator cache.no.expiration.hotkey.properties --members $MEMBERS --clients $CLIENTS --duration $DURATION --sessionId m${MEMBERS}-c${CLIENTS}-cache-hotkey-no-expiration --memberArgs "${memberArgs}" --clientArgs "${clientArgs}"
$SIMULATOR_HOME/bin/coordinator --clean
$SIMULATOR_HOME/bin/coordinator cache.expiration.hotkey.properties --members $MEMBERS --clients $CLIENTS --duration $DURATION --sessionId m${MEMBERS}-c${CLIENTS}-hotkey-cache-expiration --memberArgs "${memberArgs}" --clientArgs "${clientArgs}"
$SIMULATOR_HOME/bin/coordinator --clean
