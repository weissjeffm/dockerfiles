FROM ubuntu:14.04

MAINTAINER Filip Gospodinov "filip@monetas.net"

LABEL name=java-base
LABEL version=2

ADD pom.xml ./

RUN apt-get update && \
    apt-get install -y --no-install-recommends git maven openjdk-7-jdk && \
    apt-get autoremove

RUN mvn install

CMD ["bash"]
