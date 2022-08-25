FROM alpine:3.15.6

RUN apk update \
	&& apk add --no-cache vsftpd \
	&& wget -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 \
	&& chmod +x /usr/bin/dumb-init

COPY tools/run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY conf/self-signed.crt /etc/ssl/self-signed.crt
COPY conf/self-signed.key /etc/ssl/self-signed.key

EXPOSE 21

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]

CMD ["/tmp/run.sh"]