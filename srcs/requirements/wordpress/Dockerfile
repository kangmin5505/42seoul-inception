FROM alpine:3.15.6

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	/usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

RUN wget -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 \
    && chmod +x /usr/bin/dumb-init

RUN apk update \
	&& apk add --no-cache php7-common php7-session php7-iconv php7-json php7-gd \
		php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql \
		php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype \
		php7-dom php7-simplexml php7 php7-phar php7-fpm mariadb-client


COPY tools/run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

EXPOSE 9000

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]

CMD [ "/tmp/run.sh" ]