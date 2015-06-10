FROM ubuntu:14.04

MAINTAINER Filip Gospodinov "filip@monetas.net"

LABEL name=java-base
LABEL version=6

RUN apt-get update && \
    apt-get install -y --no-install-recommends git wget unzip openjdk-7-jdk software-properties-common && \
    add-apt-repository ppa:monetas/opentxs && \
    apt-get update && \
    apt-get install -y --no-install-recommends libsodium13 && \
    ln -s /usr/lib/x86_64-linux-gnu/libsodium.so.13 /usr/lib/x86_64-linux-gnu/libsodium.so && \
    apt-get autoremove

#Install gradle
ENV GRADLE_DIR gradle-2.4
ENV GRADLE_IMAGE $GRADLE_DIR-all.zip
RUN wget https://services.gradle.org/distributions/$GRADLE_IMAGE && \
    unzip -d /opt/ $GRADLE_IMAGE && \
    rm $GRADLE_IMAGE
ENV GRADLE_HOME /opt/$GRADLE_DIR
ENV PATH $GRADLE_HOME/bin:$PATH

CMD ["bash"]
