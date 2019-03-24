
[uri_license]: http://www.gnu.org/licenses/agpl.html
[uri_license_image]: https://img.shields.io/badge/License-AGPL%20v3-blue.svg

[![License: AGPL v3][uri_license_image]][uri_license]
[![Build Status](https://travis-ci.org/Monogramm/docker-taiga-front-base.svg)](https://travis-ci.org/Monogramm/docker-taiga-front-base)
[![Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-taiga-front-base.svg)](https://hub.docker.com/r/monogramm/docker-taiga-front-base/)
[![Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-taiga-front-base.svg)](https://hub.docker.com/r/monogramm/docker-taiga-front-base/)
[![](https://images.microbadger.com/badges/version/monogramm/docker-taiga-front-base.svg)](https://microbadger.com/images/monogramm/docker-taiga-front-base)
[![](https://images.microbadger.com/badges/image/monogramm/docker-taiga-front-base.svg)](https://microbadger.com/images/monogramm/docker-taiga-front-base)


# Docker image for taiga-front

This Docker repository provides the [taiga-front](https://github.com/taigaio/taiga-front) server with a configuration suitable to use with [taiga-back](https://github.com/taigaio/taiga-back).

This image was inspired by [ajira86/docker-taiga](https://github.com/ajira86/docker-taiga) which is a fork of [benhutchins/docker-taiga](https://github.com/benhutchins/docker-taiga).

For a more advanced image and full docker-compose example, checkout [Monogramm/docker-taiga](https://github.com/Monogramm/docker-taiga).


## What is Taiga?

Taiga is a project management platform for startups and agile developers & designers who want a simple, beautiful tool that makes work truly enjoyable.

> [taiga.io](https://taiga.io)


## Build Docker image

To generate docker images from the template, execute `update.sh` script.

Install Docker and then run `docker build -t docker-taiga-front-base images/VARIANT/VERSION` to build the image for the variant and version you need.

You can also build all images by running `update.sh build`.


# Adding Features
If the image does not include the packages you need, you can easily build your own image on top of it.
Start your derived image with the `FROM` statement and add whatever you like.

```Dockerfile
FROM monogramm/docker-taiga-front-base:alpine

RUN ...

```

You can also clone this repository and use the [update.sh](update.sh) shell script to generate a new Dockerfile based on your own needs.

For instance, you could build a container based on Dolibarr develop branch by setting the `update.sh` versions like this:
```bash
latests=( "master" )
```
Then simply call [update.sh](update.sh) script.

```console
bash update.sh
```
Your Dockerfile(s) will be generated in the `images/` folder.


## Auto configuration via environment variables

The Taiga image supports auto configuration via environment variables. You can preconfigure nearly everything that is available in `conf.json`.

See [conf.example.json](https://github.com/taigaio/taiga-front/blob/master/conf/conf.example.json) for more details on configuration.


### TAIGA_HOSTNAME

*Default value*: `localhost`

Your service hostname (REQUIRED). Remember to set it in the backend too.

Examples:
```
TAIGA_HOSTNAME=localhost
TAIGA_HOSTNAME=taiga.company.com
```

### TAIGA_SSL

*Default value*: `False`

Activate SSL. Remember to enable it in the backend too.

Examples:
```
TAIGA_SSL=False
TAIGA_SSL=True
```

### TAIGA_SSL_BY_REVERSE_PROXY

*Default value*: `False`

Activate SSL through a reverse proxy. If this is `True`, `TAIGA_SSL` is ignored. Remember to enable it in the backend too.

Examples:
```
TAIGA_SSL_BY_REVERSE_PROXY=False
TAIGA_SSL_BY_REVERSE_PROXY=True
```

### TAIGA_DEBUG

*Default value*: `false`

Enable Taiga frontend debug mode.

Examples:
```
TAIGA_DEBUG=false
TAIGA_DEBUG=true
TAIGA_DEBUG=
```

### TAIGA_DEBUG_INFO

*Default value*: `false`

Enable Taiga frontend debug information.

Examples:
```
TAIGA_DEBUG_INFO=false
TAIGA_DEBUG_INFO=true
TAIGA_DEBUG_INFO=
```

### TAIGA_DEFAULT_LANGUAGE

*Default value*: `en`

Taiga frontend default language.

Examples:
```
TAIGA_DEBUG_INFO=en
TAIGA_DEBUG_INFO=fr
```

### TAIGA_DEFAULT_THEME

*Default value*: `taiga`

Taiga frontend default theme.

Examples:
```
TAIGA_DEBUG_INFO=taiga
TAIGA_DEBUG_INFO=material-design
TAIGA_DEBUG_INFO=high-contrast
```

### TAIGA_PUBLIC_REGISTER_ENABLED

*Default value*: `false`

Enable Taiga frontend registration.

Examples:
```
TAIGA_PUBLIC_REGISTER_ENABLED=false
TAIGA_PUBLIC_REGISTER_ENABLED=true
TAIGA_PUBLIC_REGISTER_ENABLED=
```

### TAIGA_SUPPORT_URL

*Default value*: `https://tree.taiga.io/support`

Taiga frontend support URL.

Examples:
```
TAIGA_SUPPORT_URL=https://tree.taiga.io/support
TAIGA_SUPPORT_URL=https://taiga.company.com/support
TAIGA_SUPPORT_URL=
```

### TAIGA_PRIVACY_POLICY_URL

*Default value*:

Taiga frontend privacy policy URL.

Examples:
```
TAIGA_PRIVACY_POLICY_URL=https://taiga.io/privacy-policy.html
TAIGA_PRIVACY_POLICY_URL=https://taiga.company.com/privacy-policy
TAIGA_PRIVACY_POLICY_URL=
```

### TAIGA_TOS_URL

*Default value*:

Taiga frontend terms of services URL.

Examples:
```
TAIGA_TOS_URL=https://taiga.io/terms-of-service.html
TAIGA_TOS_URL=https://taiga.company.com/terms-of-service
TAIGA_TOS_URL=
```

### TAIGA_GDPR_URL

*Default value*:

Taiga frontend GDPR compliance URL.

Examples:
```
TAIGA_GDPR_URL=https://taiga.io/gdpr-compliance.html
TAIGA_GDPR_URL=https://taiga.company.com/gdpr-compliance
TAIGA_GDPR_URL=
```

### TAIGA_MAX_UPLOAD_SIZE

*Default value*: `104857600` (100 Mo)

Taiga frontend max file upload size.

Examples:
```
TAIGA_MAX_UPLOAD_SIZE=104857600
TAIGA_MAX_UPLOAD_SIZE=20480
TAIGA_MAX_UPLOAD_SIZE=
```

### TAIGA_CONTRIB_PLUGINS

*Default value*:

Taiga frontend plugins installed. Remember to install and configure your plugins in the backend too.

Examples:
```
TAIGA_CONTRIB_PLUGINS=slack
TAIGA_CONTRIB_PLUGINS='slack call-to-action cookie-warning'
TAIGA_CONTRIB_PLUGINS=
```

### TAIGA_IMPORTERS

*Default value*:

Taiga frontend importers installed. Remember to enable importers in the backend too.

Examples:
```
TAIGA_IMPORTERS=github
TAIGA_IMPORTERS='github jira trello asana'
TAIGA_IMPORTERS=
```

### TAIGA_GRAVATAR

*Default value*: `true`

Enable Taiga Gravatar usage for usage profile pictures.

Examples:
```
TAIGA_GRAVATAR=false
TAIGA_GRAVATAR=true
TAIGA_GRAVATAR=
```

### TAIGA_LOGIN_FORM_TYPE

*Default value*: `normal`

Taiga frontend login form type.

Examples:
```
TAIGA_LOGIN_FORM_TYPE=normal
TAIGA_LOGIN_FORM_TYPE=
```

### TAIGA_BACK_HOST

*Default value*: `taigaback`

Taiga backend host for Nginx proxy.

Examples:
```
TAIGA_BACK_HOST=taigaback
TAIGA_BACK_HOST=back
TAIGA_BACK_HOST=taiga_back
```

### TAIGA_BACK_PORT

*Default value*: `8001`

Taiga backend port for Nginx proxy.

Examples:
```
TAIGA_BACK_PORT=8001
TAIGA_BACK_PORT=18000
```

### TAIGA_EVENTS_ENABLED

*Default value*:

Enable Taiga events. Remember to enable it in the backend too.

Examples:
```
TAIGA_EVENTS_ENABLED=1
TAIGA_EVENTS_ENABLED=True
TAIGA_EVENTS_ENABLED=
```

### TAIGA_EVENTS_HOST

*Default value*: `taigaevents`

Taiga events host for Nginx proxy.

Examples:
```
TAIGA_EVENTS_HOST=taigaevents
TAIGA_EVENTS_HOST=events
TAIGA_EVENTS_HOST=taiga_events
```

### TAIGA_EVENTS_PORT

*Default value*: `8888`

Taiga events port for Nginx proxy.

Examples:
```
TAIGA_EVENTS_PORT=8443
TAIGA_EVENTS_PORT=18888
```
