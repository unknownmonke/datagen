ARG FLINK_VERSION=1.20.2-scala_2.12-java11

FROM flink:$FLINK_VERSION

ARG FLINK_KAFKA_SQL_CONNECTOR_VERSION=3.4.0-1.20
ARG FLINK_FAKER_VERSION=0.5.3

RUN wget -P /opt/flink/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka/$FLINK_KAFKA_SQL_CONNECTOR_VERSION/flink-sql-connector-kafka-$FLINK_KAFKA_SQL_CONNECTOR_VERSION.jar; \
    wget -P /opt/flink/lib/ https://github.com/knaufk/flink-faker/releases/download/v$FLINK_FAKER_VERSION/flink-faker-$FLINK_FAKER_VERSION.jar;

RUN chown -R flink:flink /opt/flink/lib