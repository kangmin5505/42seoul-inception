FROM alpine:3.15.6

RUN apk update \
	&& apk add --no-cache curl php7 php7-mysqli php7-fpm php7-session \
	&& wget -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 \
	&& chmod +x /usr/bin/dumb-init

COPY tools/run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

RUN sed -i "s/.*listen = 127.0.0.1.*/listen = 8080/g" /etc/php7/php-fpm.d/www.conf

EXPOSE 8080

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]

CMD ["/tmp/run.sh"]