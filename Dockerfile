FROM alpine:3.9
LABEL maintainer "LuxAeterna"

ENV CADDYPATH=/caddy/.caddy RUN_ARGS=
ARG plugins=http.cache,http.realip,http.nobots,http.minify,http.cgi
#ARG dns=tls.dns.dyn
EXPOSE 80 443 2015
VOLUME /var/www /caddy
WORKDIR /caddy
ENTRYPOINT ["/start.sh"]
COPY Caddyfile /caddy/
COPY index.html /var/www/
COPY Caddyfile index.html /opt/assets/
COPY start.sh /
RUN apk add --no-cache tar curl ca-certificates bash && update-ca-certificates && mkdir -p /opt/assets
RUN curl --silent https://getcaddy.com | /bin/bash -s personal $plugins #,$dns
