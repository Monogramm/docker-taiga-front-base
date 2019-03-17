FROM nginx:alpine

LABEL maintainer="Mathieu BRUNOT <mathieu.brunot at monogramm dot io>"

ENV TAIGA_VERSION=3.4.6 \
    TAIGA_HOSTNAME=localhost \
	TAIGA_SSL=False \
    TAIGA_SSL_BY_REVERSE_PROXY=False \
    RABBIT_PORT_5672_TCP_ADDR=''

VOLUME /taiga

COPY conf/nginx /etc/
COPY conf/taiga/conf.json /taiga/conf.json

# Get Taiga
ADD https://github.com/taigaio/taiga-front-dist/archive/${TAIGA_VERSION}-stable.tar.gz /tmp/taiga-front-dist-${TAIGA_VERSION}-stable.tar.gz

RUN set -ex; \
    apk add --no-cache \
        ca-certificates \
        gettext \
        tar \
    ; \
    # forward request and error logs to docker log collector
	#ln -sf /dev/stdout /var/log/nginx/access.log; \
	#ln -sf /dev/stderr /var/log/nginx/error.log; \
    # Install Taiga from tag archive
    mkdir -p /tmp/taiga-front-dist; \
	tar xzf /tmp/taiga-front-dist-${TAIGA_VERSION}-stable.tar.gz -C /tmp/taiga-front-dist; \
	rm /tmp/taiga-front-dist-${TAIGA_VERSION}-stable.tar.gz; \
	mkdir -p /usr/src/taiga-front-dist; \
	cp -r /tmp/taiga-front-dist/taiga-front-dist-${TAIGA_VERSION}-stable/* /usr/src/taiga-front-dist; \
	rm -rf /tmp/taiga-front-dist; \
    # Setup symbolic links for configuration files
	ln -s /taiga/conf.json /usr/src/taiga-front-dist/dist/conf.json; \
    # Backwards compatibility
	mkdir -p /usr/src/taiga-front-dist/dist/js/; \
    ln -s /taiga/conf.json /usr/src/taiga-front-dist/dist/js/conf.json
