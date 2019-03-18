FROM nginx:alpine

LABEL maintainer="Mathieu BRUNOT <mathieu.brunot at monogramm dot io>"

# Taiga nginx, back, and events properties
ENV TAIGA_VERSION=4.0.4 \
    TAIGA_HOSTNAME=localhost \
	TAIGA_SSL=False \
    TAIGA_SSL_BY_REVERSE_PROXY=False \
    TAIGA_BACK_HOST=taigaback \
    TAIGA_BACK_PORT=8000 \
    TAIGA_EVENTS_HOST=taigaevents \
    TAIGA_EVENTS_PORT=8888 \
    RABBIT_PORT_5672_TCP_ADDR=''

VOLUME /taiga

COPY entrypoint.sh /
COPY conf/nginx /etc/
COPY conf/taiga/conf.json /taiga/conf.json

# Get Taiga
ADD https://github.com/taigaio/taiga-front-dist/archive/${TAIGA_VERSION}-stable.tar.gz /tmp/taiga-front-dist-${TAIGA_VERSION}-stable.tar.gz

# Install the packages we need
# forward request and error logs to docker log collector
#   ln -sf /dev/stdout /var/log/nginx/access.log; \
#   ln -sf /dev/stderr /var/log/nginx/error.log; \
# Install Taiga from tag archive
# Setup symbolic links for configuration files
# Backwards compatibility
RUN set -ex; \
    apk add --no-cache \
        ca-certificates \
        gettext \
        tar \
    ; \
    chmod 755 /entrypoint.sh; \
    mkdir -p /tmp/taiga-front-dist; \
	tar xzf /tmp/taiga-front-dist-${TAIGA_VERSION}-stable.tar.gz -C /tmp/taiga-front-dist; \
	rm /tmp/taiga-front-dist-${TAIGA_VERSION}-stable.tar.gz; \
	mkdir -p /usr/src/taiga-front-dist; \
	cp -r /tmp/taiga-front-dist/taiga-front-dist-${TAIGA_VERSION}-stable/* /usr/src/taiga-front-dist; \
	rm -rf /tmp/taiga-front-dist; \
	ln -s /taiga/conf.json /usr/src/taiga-front-dist/dist/conf.json; \
	mkdir -p /usr/src/taiga-front-dist/dist/js/; \
    ln -s /taiga/conf.json /usr/src/taiga-front-dist/dist/js/conf.json

# Frontend healthcheck
HEALTHCHECK CMD curl --fail http://localhost:80/conf.json || exit 1

ENTRYPOINT ["/entrypoint.sh"]
