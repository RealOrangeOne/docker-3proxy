# 3proxy docker
#
# VERSION               0.1
# Run with: docker run --rm --name miniproxy -d -p 3128:3128 -p 31331:31331 riftbit/miniproxy
# or docker run --rm --name miniproxy -t -i -p 3128:3128 -p 31331:31331 riftbit/miniproxy

FROM alpine:latest
MAINTAINER Riftbit ErgoZ <ergozru@riftbit.com>

RUN apk add --update alpine-sdk && \
    apk add --update wget && \
    echo "Getting 3proxy sources..." && \
    wget -q http://3proxy.ru/0.8.11/3proxy-0.8.11.tgz && \
    echo "Unpacking 3proxy sources..." && \
    tar -xf 3proxy-0.8.11.tgz && \
    rm 3proxy-0.8.11.tgz && \
    cd 3proxy && \
    echo "Compiling 3proxy from sources..." && \
    make -f Makefile.Linux && \
    mkdir /etc/3proxy && \
    echo "Move binaries..." && \
    cd src && \
    mv 3proxy /etc/3proxy/

COPY docker-entrypoint.sh /entrypoint.sh

EXPOSE 3128/tcp 31331/tcp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["start_proxy"]
