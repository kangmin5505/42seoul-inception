FROM alpine:3.15.6

RUN apk update \
	&& apk add --no-cache nginx openssl \
	&& wget -q -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 \
	&& chmod +x /usr/bin/dumb-init

COPY conf/self-signed.crt /etc/nginx/ssl/self-signed.crt
COPY conf/self-signed.key /etc/nginx/ssl/self-signed.key
COPY conf/default.conf /etc/nginx/http.d/default.conf

COPY tools/run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

EXPOSE 443

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]

CMD [ "/tmp/run.sh" ]