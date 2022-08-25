FROM alpine:3.15.6

RUN apk update \
	&& apk add --no-cache curl \
	&& wget -q -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 \
	&& chmod +x /usr/bin/dumb-init \
	&& curl -s -L -o /usr/bin/cadvisor	https://github.com/google/cadvisor/releases/download/v0.45.0/cadvisor-v0.45.0-linux-arm64 \
	&& chmod +x /usr/bin/cadvisor

COPY tools/run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

EXPOSE 8080

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]

CMD ["/tmp/run.sh"]