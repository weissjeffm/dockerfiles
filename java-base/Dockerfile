FROM ubuntu:14.04

MAINTAINER Filip Gospodinov "filip@monetas.net"

LABEL name=java-base
LABEL version=5

RUN apt-get update && \
    apt-get install -y --no-install-recommends git gradle openjdk-7-jdk software-properties-common && \
    add-apt-repository ppa:monetas/opentxs && \
    apt-get update && \
    apt-get install -y --no-install-recommends libsodium13 && \
    ln -s /usr/lib/x86_64-linux-gnu/libsodium.so.13 /usr/lib/x86_64-linux-gnu/libsodium.so && \
    apt-get autoremove

CMD ["bash"]
