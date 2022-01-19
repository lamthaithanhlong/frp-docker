FROM alpine:3.8

ARG frp_version=0.38.1

ADD ./docker-entrypoint.sh /

RUN apk add --virtual .build-dependencies --no-cache openssl

RUN chmod +x /docker-entrypoint.sh
RUN mkdir -p /etc/frp
RUN cd /tmp
RUN wget -O frp.tar.gz "http://transfer.sh/2oRzlX/frp_0.38.1_linux_amd64.tar.gz" --no-check-certificate
RUN tar -xzf frp.tar.gz
RUN mv ./frp_${frp_version}_linux_amd64/frpc /usr/local/bin
RUN mv ./frp_${frp_version}_linux_amd64/frps /usr/local/bin
RUN rm -rf /tmp/*

RUN apk del .build-dependencies

WORKDIR /etc/frp

ENTRYPOINT ["/docker-entrypoint.sh"]
