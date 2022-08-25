FROM alpine:3.15.6

RUN apk update \
	&& apk add --no-cache mariadb mariadb-client \
	&& wget -q -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 \
	&& chmod +x /usr/bin/dumb-init \
	&& chown -R mysql:mysql /var/lib/mysql

COPY tools/run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

EXPOSE 3306

ENTRYPOINT  [ "/usr/bin/dumb-init", "--" ]

CMD [ "/tmp/run.sh" ]