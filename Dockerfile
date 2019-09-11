FROM alpine:3.10.2

ENV key id_rsa
ENV timerange "-inf:+inf"


RUN apk update && \
	apk add --no-cache nginx && \
    apk add --no-cache openssh && \
    apk add --no-cache bash

COPY id_rsa /id_rsa
COPY default.conf /etc/nginx/conf.d/default.conf
COPY ssh.sh /ssh.sh

CMD ["bash", "./ssh.sh"]