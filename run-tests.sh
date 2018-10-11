#!/bin/sh
SIMULATOR_HOME=~/hazelcast-simulator-0.11-SNAPSHOT
MEMBERS=2
CLIENTS=1
DURATION=2m

$SIMULATOR_HOME/bin/coordinator cache.no.expiration.properties --members $MEMBERS --clients $CLIENTS --duration $DURATION --sessionId m${MEMBERS}-c${CLIENTS}-cache-no-expiration
$SIMULATOR_HOME/bin/coordinator cache.expiration.properties --members $MEMBERS --clients $CLIENTS --duration $DURATION --sessionId m${MEMBERS}-c${CLIENTS}-cache-expiration
$SIMULATOR_HOME/bin/coordinator cache.expiration.properties --members $MEMBERS --clients $CLIENTS --duration $DURATION --sessionId m${MEMBERS}-c${CLIENTS}-cache-expiration-delay-task --memberArgs -Dhazelcast.internal.cache.expiration.task.period.seconds=300
$SIMULATOR_HOME/bin/coordinator cache.no.expiration.properties --members $MEMBERS --clients $CLIENTS --duration $DURATION --sessionId m${MEMBERS}-c${CLIENTS}-cache-no-expiration-100 --memberArgs -Dhazelcast.internal.cache.expiration.cleanup.percentage=100
$SIMULATOR_HOME/bin/coordinator cache.expiration.properties --members $MEMBERS --clients $CLIENTS --duration $DURATION --sessionId m${MEMBERS}-c${CLIENTS}-cache-expiration-100 --memberArgs -Dhazelcast.internal.cache.expiration.cleanup.percentage=100
$SIMULATOR_HOME/bin/coordinator cache.no.expiration.hotkey.properties --members $MEMBERS --clients $CLIENTS --duration $DURATION --sessionId m${MEMBERS}-c${CLIENTS}-cache-hotkey-no-expiration
$SIMULATOR_HOME/bin/coordinator cache.expiration.hotkey.properties --members $MEMBERS --clients $CLIENTS --duration $DURATION --sessionId m${MEMBERS}-c${CLIENTS}-hotkey-cache-expiration
