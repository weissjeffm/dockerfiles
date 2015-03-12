FROM dockerfile/ubuntu

MAINTAINER Filip Gospodinov "filip@monetas.net"

ADD postgres ./postgres
ADD install.sh ./
RUN sh install.sh

ADD run_services.sh /opt/

# use custom GOPATH such that it does not conflict with GOPATHs that
# live inside the host's $HOME which may be bind mounted into docker
ENV GOPATH /opt/go
ENV GOROOT /opt/go_dist/go
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH
ADD https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz ./
ADD dependencies ./
RUN mkdir /opt/go_dist && tar -x -C /opt/go_dist -f ./go1.4.2.linux-amd64.tar.gz
RUN while read dep sha1; do \
        go get "$dep" && cd "$GOPATH/src/$dep" && git checkout "$sha1"; \
    done < dependencies

CMD ["bash"]
