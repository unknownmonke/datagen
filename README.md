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

<br>

Notes on Flink deployment :

- **Application mode** :

    - Boots a cluster for each job, destroyed after job finishes.

- [**Session mode**](https://nightlies.apache.org/flink/flink-docs-stable/docs/deployment/resource-providers/standalone/docker/#session-mode-1) :

    - Boots a long-running cluster that can accept multiple jobs and not tied to a particular job.

- Flink is deployed in session mode.

- The SQL Kafka connector and data generation tool need to be fetched and made available to both job and task managers in `/opt/flink/lib`.

<br>

Notes on `ARG` interactions in Dockerfile :

- `FROM` instructions support variables that are declared by any `ARG` instructions that occur **before the first** `FROM`.

- An `ARG` declared before a `FROM` is outside the build stage, so it can't be used in any instruction after.

- To use the default value of an `ARG` declared before the first `FROM` use an `ARG` instruction without a value inside of a build stage :

    ``` Dockerfile
    ARG VERSION=latest
    FROM busybox:$VERSION
    ARG VERSION
    RUN echo $VERSION > image_version
    ```
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
- Must be fetched manually for now.
- `.env` regoups versions & license URL.