# Data generation for streaming applications

**Features** :

- Setup for streaming data generation.
- Quick setup for Kafka and Flink for testing.
- Performance testing for Kafka.

<br>

This repository contains :

- A `docker-compose` for testing with :

    - *Kafka cluster*.
    - *Flink cluster*.
    - *Flink SQL client* with :
        - Kafka SQL connector.
        - *Flink Faker* for simple data generation directly to Flink.

- A [ShadowTraffic](https://docs.shadowtraffic.io/overview/) setup to generate complex infinite data for streaming applications.

- A setup to export **performance reports** for Kafka using `kafka-producer-perf-test` and `kafka-consumer-perf-test` CLI.

<br>

*Notes on Flink deployment* :

- Flink is deployed in session mode.

- The SQL Kafka connector and data generation tool need to be fetched and made available to both job and task managers in `/opt/flink/lib`.

<br>

*Details :*

- `.env` centralizes versions to use in Dockerfile and docker compose.

<br>

## Data generation with ShadowTraffic

- `/shadowtraffic/connections/connections.json` :

    - Contains the connection file to specify where to connect.
    - Only holds a Kafka sink for now.

- `/shadowtraffic/data/` :

    - Holds generators specific data, such as initial values or fixed value pools.

- `/shadowtraffic/generators/` :

    - Defines data structure for events.
    - Add new generators for new data.

- `/shadowtraffic/root.json` :

    - Main aggregator file.
    - Generators and connections must be referenced here.
    - The scheduler allows to only select a subset of active generators among registered ones.

- Once ready, execute `run.bat` or `run.sh` from directory.

#
### License

- Free trial license is fetched from example repository, valid for 30 days and rotated regularly.

- Must be fetched manually at [this URL](https://raw.githubusercontent.com/ShadowTraffic/shadowtraffic-examples/master/free-trial-license-docker.env).

<br>

## Kafka Performance Tests

- Uses `kafka-producer-perf-test` and `kafka-consumer-perf-test` CLI to stress-test the cluster.

- [Source document with examples and details.](https://github.com/ableasdale/kafka-producer-perf-test-walkthrough/blob/main/README.md)

- `/kafka-performance-tests` :

    - Contains scripts to launch in the container.
    - Run test command with specified **params** and **configuration**.

- Output is logged into a log file with timestamp to be analysed :

    - `test-[producer,consumer]-yyyy-mm-dd_hhmmss.log`.
    - Example file included.

- Can **tune performances** by editing `producer.properties` and `consumer.properties`.

#
### Producer perf test walkthrough

- Launch cluster :

    ``` bash
    docker compose up -d kafka-cluster
    ```

- Create topic :

    ``` bash
    docker exec -w "/opt/kafka/bin" kafka-cluster sh -c "./kafka-topics.sh --bootstrap-server kafka-cluster:29092 --topic test-perf --create --partitions 5"
    ```

- Tune producer configuration :

    ``` properties
    bootstrap.servers=kafka-cluster:29092
    linger.ms=100
    batch.size=32768
    ...
    ```

- Execute script :

    ``` bash
    docker exec -w "/home/logs" kafka-cluster sh -c "./producer.sh"
    ```
    *Ex :*

    ``` bash
    D:\projects\datagen> docker exec -w "/home/logs" kafka-cluster sh -c "./producer.sh"
    Running producer perf test with params : throughput=-1, record size=100, num records=1000000, topic=test-perf
    Saved to /home/logs/test-producer-2026-04-21_214750.log
    ----------------------------------------
    ```

- Find result in `/kafka-performance-tests` directory.

#
### Consumer perf test walkthrough

- Launch cluster :

    ``` bash
    docker compose up -d kafka-cluster
    ```

- Specify an existing topic with data in `consumer.sh` :

    ``` bash
    TOPIC="test-perf"
    ```

- Tune consumer configuration :

    ``` properties
    auto.offset.reset=earliest
    max.poll.interval.ms=300000
    max.poll.records=500
    ...
    ```

- Execute script :

    ``` bash
    docker exec -w "/home/logs" kafka-cluster sh -c "./consumer.sh"
    ```
    *Ex :*

    ``` bash
    PS D:\projects\datagen> docker exec -w "/home/logs" kafka-cluster sh -c "./consumer.sh"                                                                                         
    Running consumer perf test with params : fetch size=100, messages=1000000, topic=test-perf
    Saved to /home/logs/test-consumer-2026-04-22_102040.log
    ----------------------------------------
    ```

- Find result in `/kafka-performance-tests` directory.