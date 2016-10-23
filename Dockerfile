FROM alpine:latest

ADD start_runit /sbin/

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && \
    apk --update upgrade \
    && \
    apk add runit gettext \
    && \
    rm -rf /var/cache/apk/*
    && \
    mkdir /etc/runit_envvars \
    && \
    chmod 750 /etc/runit_envvars \
    && \
    chmod a+x /sbin/start_runit \
    && \
    mkdir /etc/runit_init.d \
    && \
    adduser -h /etc/user-service -s /bin/sh -D user-service -u 2000 \
    && \
    chown user-service:user-service /etc/user-service

CMD [ "/sbin/start_runit" ]