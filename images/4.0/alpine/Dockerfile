FROM nginx:alpine

LABEL maintainer="Monogramm maintainers <opensource at monogramm dot io>"

VOLUME /taiga

COPY entrypoint.sh /
COPY conf/nginx/nginx.conf          /etc/
COPY conf/nginx/sites-available/*   /etc/nginx/sites-available/
COPY conf/nginx/snippets/*          /etc/nginx/snippets/
COPY conf/taiga/conf.json /taiga/

# Build version
ARG TAIGA_VERSION=4.0.4

# Get Taiga
ADD https://github.com/taigaio/taiga-front-dist/archive/${TAIGA_VERSION}-stable.tar.gz /tmp/taiga-front-dist-${TAIGA_VERSION}-stable.tar.gz

# Install the packages we need
# Install Taiga from tag archive
# Setup symbolic links for configuration files
# Backwards compatibility
RUN set -ex; \
    apk add --no-cache \
        ca-certificates \
        curl \
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

## Runtime environment variables
# Taiga nginx, back, front and events properties
ENV TAIGA_HOSTNAME=localhost \
    TAIGA_SSL=False \
    TAIGA_SSL_BY_REVERSE_PROXY=False \
    TAIGA_BACKEND_SSL=False \
    TAIGA_DEBUG=false \
    TAIGA_DEBUG_INFO=false \
    TAIGA_DEFAULT_LANGUAGE=en \
    TAIGA_THEMES= \
    TAIGA_DEFAULT_THEME=taiga \
    TAIGA_PUBLIC_REGISTER_ENABLED=false \
    TAIGA_FEEDBACK_ENABLED=false \
    TAIGA_SUPPORT_URL=https://tree.taiga.io/support \
    TAIGA_PRIVACY_POLICY_URL= \
    TAIGA_TOS_URL= \
    TAIGA_GDPR_URL= \
    TAIGA_MAX_UPLOAD_SIZE=104857600 \
    TAIGA_CONTRIB_PLUGINS= \
    TAIGA_IMPORTERS= \
    TAIGA_GRAVATAR=true \
    TAIGA_LOGIN_FORM_TYPE=normal \
    TAIGA_BACK_HOST=taigaback \
    TAIGA_BACK_PORT=8001 \
    TAIGA_EVENTS_ENABLED= \
    TAIGA_EVENTS_HOST=taigaevents \
    TAIGA_EVENTS_PORT=8888

ENTRYPOINT ["/entrypoint.sh"]
