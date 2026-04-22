# --------------------------------- Compose ---------------------------------- #

docker compose up --build -d
docker compose up -d kafka-cluster

docker-compose logs

docker compose run sql-client
docker compose down -v --remove-orphans

docker exec -it -w "/opt/kafka/bin" kafka-cluster bash

# ---------------------------------- Kafka ----------------------------------- #

# Consumer :
./kafka-console-consumer.sh --bootstrap-server kafka-cluster:29092 --from-beginning --topic transactions

# Create topic :
./kafka-topics.sh --bootstrap-server kafka-cluster:29092 --topic test-perf --create --partitions 5

# Check topic :
./kafka-topics.sh --bootstrap-server kafka-cluster:29092 --topic test-perf --describe

# Check topic dynamic config :
./kafka-configs.sh --bootstrap-server kafka-cluster:29092 --entity-type topics --entity-name test-perf --describe

# Alter topic config :
./kafka-configs.sh --bootstrap-server kafka-cluster:29092 --entity-type topics --entity-name test-perf --alter --add-config retention.ms=3600000

# Delete topic config :
./kafka-configs.sh --bootstrap-server kafka-cluster:29092 --entity-type topics --entity-name test-perf --alter --delete-config retention.ms

# -------------------------------- Perf tests -------------------------------- #

# Lauch a producer perf test :
./kafka-producer-perf-test.sh --throughput -1 --topic test-perf --num-records 1000000 --record-size 1000 --producer-props bootstrap.servers=kafka-cluster:29092 --print-metrics

# Lauch a consumer perf test :
./kafka-consumer-perf-test.sh --topic test-perf --fetch-size 1000 --messages 1000000 --bootstrap-server kafka-cluster:29092 --print-metrics

# Execute the producer perf test script :
docker exec -w "/home/logs" kafka-cluster sh -c "./producer.sh"

# Execute the consumer perf test script :
docker exec -w "/home/logs" kafka-cluster sh -c "./consumer.sh"