# Data generation for streaming applications

- Setup for streaming data generation.
- Quick setup for Kafka and Flink for testing.

<br>

This repository contains :

- A `docker-compose` for testing with :

    - *Kafka cluster*.
    - *Flink cluster*.
    - *Flink SQL client* with :
        - Kafka SQL connector.
        - *Flink Faker* for simple data generation directly to Flink.

- A [ShadowTraffic](https://docs.shadowtraffic.io/overview/) setup to generate complex infinite data for streaming applications.

- `.env` centralizes versions to use in Dockerfile and docker compose.

<br>

*Notes on Flink deployment* :

- Flink is deployed in session mode.

- The SQL Kafka connector and data generation tool need to be fetched and made available to both job and task managers in `/opt/flink/lib`.

<br>

## Generating data with ShadowTraffic

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