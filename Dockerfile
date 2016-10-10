FROM alpine:latest

ONBUILD RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && \
    apk --update upgrade && apk add runit && rm -rf /var/cache/apk/*

ADD start_runit /sbin/

RUN mkdir /etc/container_environment \
    && \
    chmod a+x /sbin/start_runit \
    && \
    mkdir /etc/runit_init.d

CMD ["/sbin/start_runit"]