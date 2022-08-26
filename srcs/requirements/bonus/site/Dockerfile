FROM alpine:3.15.6

RUN apk update \
	&& apk add --no-cache python3 py3-pip \
	&& pip install --upgrade pip \
	&& pip install --root-user-action=ignore fastapi uvicorn \
	&& wget -q -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 \
	&& chmod +x /usr/bin/dumb-init

COPY app /srv/app
WORKDIR /srv/app

EXPOSE 8888

ENTRYPOINT  [ "/usr/bin/dumb-init", "--" ]

CMD ["uvicorn", "--host", "0.0.0.0", "--port", "8888", "main:app"]