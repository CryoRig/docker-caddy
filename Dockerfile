FROM alpine
LABEL maintainer "LuxAeterna"
LABEL caddy_version="0.11.0" architecture="amd64"

ARG plugins=http.cache,http.cors,http.jwt,http.locale,http.login,http.nobots,http.proxyprotocol,http.realip,http.reauth,http.upload
ARG dns=tls.dns.dyn

RUN apk add --no-cache tar curl ca-certificates bash && update-ca-certificates

RUN curl --silent https://getcaddy.com | /bin/bash -s personal $plugins,$dns

RUN mkdir -p /opt/assets

EXPOSE 80 443 2015

VOLUME /var/www
VOLUME /caddy
WORKDIR /var/www
WORKDIR /caddy

ENV CADDYPATH=/caddy/.caddy
ENV RUN_ARGS=

COPY Caddyfile /caddy/
COPY index.html /var/www/
COPY Caddyfile /opt/assets/
COPY index.html /opt/assets/
COPY start.sh /

ENTRYPOINT ["/start.sh"]
