FROM debian:buster

RUN apt-get update \
	&& apt-get install -y wget curl \
	&& wget -q -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 \
	&& chmod +x /usr/bin/dumb-init \
	&& curl -s -L -o /usr/bin/cadvisor	https://github.com/google/cadvisor/releases/download/v0.37.5/cadvisor \
	&& chmod +x /usr/bin/cadvisor

EXPOSE 8080

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]

CMD ["cadvisor", "--logtostderr"]