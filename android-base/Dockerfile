FROM monetas/java-base:6

MAINTAINER Monetas "technical@monetas.net"

LABEL name=android-base
LABEL version=1

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends libncurses5:i386 libstdc++6:i386 zlib1g:i386 && \
    apt-get autoremove

# Install android sdk
ENV ANDROID_IMAGE android-sdk_r24.2-linux.tgz
RUN wget http://dl.google.com/android/$ANDROID_IMAGE && \
    tar -C /opt/ -xzf $ANDROID_IMAGE && \
    rm $ANDROID_IMAGE

# Add android tools and platform tools to PATH
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools

# Install android sdk parts
# Android needs to confirm licences. It is not possible to use `yes` command because sleep is required.
RUN (while true; do echo "y"; sleep 2; done) | android update sdk -a --filter android-22,build-tools-22.0.1,extra-android-m2repository --no-ui

CMD ["bash"]
