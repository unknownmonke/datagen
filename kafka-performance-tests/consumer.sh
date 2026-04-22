#!/bin/bash

LOG_DIR="/home/logs"
KAFKA_ROOT="/opt/kafka"

FETCH_SIZE=100
MESSAGES=1000000
TOPIC="test-perf"

# -------------------- #

TIMESTAMP=$(date -u +"%F_%H%M%S")

LOG_FILE="${LOG_DIR}/test-consumer-${TIMESTAMP}.log"

echo "Running consumer perf test with params : fetch size=$FETCH_SIZE, messages=$MESSAGES, topic=$TOPIC"

${KAFKA_ROOT}/bin/kafka-consumer-perf-test.sh \
    --bootstrap-server "kafka-cluster:29092" \
    --topic "$TOPIC" \
    --fetch-size "$FETCH_SIZE" \
    --messages "$MESSAGES" \
    --consumer.config "consumer.properties" \
    --print-metrics \
    > "$LOG_FILE" 2>&1

echo "Saved to $LOG_FILE"
echo "----------------------------------------"