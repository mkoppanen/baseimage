FROM alpine:latest

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && \
    apk --update upgrade \
    && \
    apk add runit \
    && \
    rm -rf /var/cache/apk/*

ADD start_runit /sbin/

RUN mkdir /etc/container_environment \
    && \
    chmod a+x /sbin/start_runit \
    && \
    mkdir /etc/runit_init.d

# add user 
RUN adduser -h /etc/user-service -s /bin/sh -D user-service -u 2000

# create non-privileged
ADD user-service.init /etc/service/user-service/run
RUN chmod +x /etc/service/user-service/run

CMD ["/sbin/start_runit"]