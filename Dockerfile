FROM alpine
LABEL maintainer "LuxAeterna"

ARG plugins=http.cache,http.realip,http.nobots,http.minify
#ARG dns=tls.dns.dyn

RUN apk add --no-cache tar curl ca-certificates bash && update-ca-certificates && curl --silent https://getcaddy.com | /bin/bash -s personal $plugins #,$dns && mkdir -p /opt/assets

EXPOSE 80 443 2015

VOLUME /var/www /caddy
WORKDIR /caddy

ENV CADDYPATH=/caddy/.caddy RUN_ARGS=

COPY Caddyfile /caddy/
COPY index.html /var/www/
COPY Caddyfile index.html /opt/assets/
COPY start.sh /

ENTRYPOINT ["/start.sh"]
