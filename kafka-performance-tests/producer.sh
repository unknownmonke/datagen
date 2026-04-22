#!/bin/bash

LOG_DIR="/home/logs"
KAFKA_ROOT="/opt/kafka"

THROUGHPUT=-1
RECORD_SIZE=100
NUM_RECORDS=1000000
TOPIC="test-perf"

# -------------------- #

TIMESTAMP=$(date -u +"%F_%H%M%S")

LOG_FILE="${LOG_DIR}/test-producer-${TIMESTAMP}.log"

echo "Running producer perf test with params : throughput=$THROUGHPUT, record size=$RECORD_SIZE, num records=$NUM_RECORDS, topic=$TOPIC"

${KAFKA_ROOT}/bin/kafka-producer-perf-test.sh \
    --throughput "$THROUGHPUT" \
    --topic "$TOPIC" \
    --num-records "$NUM_RECORDS" \
    --record-size "$RECORD_SIZE" \
    --producer.config "producer.properties" \
    --print-metrics \
    > "$LOG_FILE" 2>&1

echo "Saved to $LOG_FILE"
echo "----------------------------------------"