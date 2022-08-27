FROM alpine:3.15.6

RUN wget -q -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 \
    && chmod +x /usr/bin/dumb-init

RUN apk update \
	&& apk add --no-cache redis

RUN sed -i "s/bind 127.0.0.1 -::1/bind 0.0.0.0/g" /etc/redis.conf

EXPOSE 6379

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]

CMD ["redis-server", "/etc/redis.conf"]