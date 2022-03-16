[![License: AGPL v3][uri_license_image]][uri_license]
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/Monogramm/docker-taiga-front-base/Docker%20Image%20CI)](https://github.com/Monogramm/docker-taiga-front-base/actions)
[![Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-taiga-front-base.svg)](https://hub.docker.com/r/monogramm/docker-taiga-front-base/)
[![Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-taiga-front-base.svg)](https://hub.docker.com/r/monogramm/docker-taiga-front-base/)
[![](https://images.microbadger.com/badges/version/monogramm/docker-taiga-front-base.svg)](https://microbadger.com/images/monogramm/docker-taiga-front-base)
[![](https://images.microbadger.com/badges/image/monogramm/docker-taiga-front-base.svg)](https://microbadger.com/images/monogramm/docker-taiga-front-base)

# Docker image for taiga-front

This Docker repository provides the [taiga-front](https://github.com/taigaio/taiga-front) server with a configuration suitable to use with [taiga-back](https://github.com/taigaio/taiga-back).

This image was inspired by [ajira86/docker-taiga](https://github.com/ajira86/docker-taiga) which is a fork of [benhutchins/docker-taiga](https://github.com/benhutchins/docker-taiga).

For a more advanced image and full docker-compose example, checkout [Monogramm/docker-taiga](https://github.com/Monogramm/docker-taiga).

## What is Taiga

Taiga is a project management platform for startups and agile developers & designers who want a simple, beautiful tool that makes work truly enjoyable.

> [taiga.io](https://taiga.io)

## Supported tags

<https://hub.docker.com/r/monogramm/docker-taiga-front-base/>

<!-- >Docker Tags -->

-   6.5.1-alpine 6.5-alpine alpine 6.5.1 6.5 latest  (`images/6.5/alpine/Dockerfile`)
-   6.4.3-alpine 6.4-alpine 6.4.3 6.4  (`images/6.4/alpine/Dockerfile`)
-   6.3.3-alpine 6.3-alpine 6.3.3 6.3  (`images/6.3/alpine/Dockerfile`)
-   6.2.2-alpine 6.2-alpine 6.2.2 6.2  (`images/6.2/alpine/Dockerfile`)
-   6.1.1-alpine 6.1-alpine 6.1.1 6.1  (`images/6.1/alpine/Dockerfile`)
-   6.0.10-alpine 6.0-alpine 6.0.10 6.0  (`images/6.0/alpine/Dockerfile`)

<!-- <Docker Tags -->

## Build Docker image

To generate docker images from the template, execute `update.sh` script.

Install Docker and then run `docker build -t docker-taiga-front-base images/VARIANT/VERSION` to build the image for the variant and version you need.

You can also build all images by running `update.sh build`.

## Adding Features

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

_Default value_: `localhost`

Your service hostname (REQUIRED). Remember to set it in the backend too.

Examples:

```yml
TAIGA_HOSTNAME=localhost
TAIGA_HOSTNAME=taiga.company.com
```

### TAIGA_SSL

_Default value_: `False`

Indicate SSL is enabled. Remember to enable it in the backend too.

Examples:

```yml
TAIGA_SSL=False
TAIGA_SSL=True
```

### TAIGA_SSL_BY_REVERSE_PROXY

_Default value_: `False`

Indicate SSL is enabled through a reverse proxy. If this is `True`, `TAIGA_SSL` is ignored. Remember to enable it in the backend too.

Examples:

```yml
TAIGA_SSL_BY_REVERSE_PROXY=False
TAIGA_SSL_BY_REVERSE_PROXY=True
```

### TAIGA_BACKEND_SSL

_Default value_: `False`

Indicate SSL is enabled for backend.

Examples:

```yml
TAIGA_BACKEND_SSL=False
TAIGA_BACKEND_SSL=True
```

### TAIGA_DEBUG

_Default value_: `false`

Enable Taiga frontend debug mode.

Examples:

```yml
TAIGA_DEBUG=false
TAIGA_DEBUG=true
TAIGA_DEBUG=
```

### TAIGA_DEBUG_INFO

_Default value_: `false`

Enable Taiga frontend debug information.

Examples:

```yml
TAIGA_DEBUG_INFO=false
TAIGA_DEBUG_INFO=true
TAIGA_DEBUG_INFO=
```

### TAIGA_DEFAULT_LANGUAGE

_Default value_: `en`

Taiga frontend default language.

Examples:

```yml
TAIGA_DEBUG_INFO=en
TAIGA_DEBUG_INFO=fr
```

### TAIGA_THEMES

_Default value_:

Taiga frontend themes installed.

Examples:

```yml
TAIGA_THEMES=
TAIGA_THEMES=taiga
TAIGA_THEMES='taiga material-design high-contrast'
TAIGA_THEMES='taiga legacy material-design high-contrast'
```

### TAIGA_DEFAULT_THEME

_Default value_: `taiga`

Taiga frontend default theme.

Examples:

```yml
TAIGA_DEFAULT_THEME=taiga
TAIGA_DEFAULT_THEME=material-design
TAIGA_DEFAULT_THEME=high-contrast
```

### TAIGA_PUBLIC_REGISTER_ENABLED

_Default value_: `false`

Enable Taiga frontend registration.

Examples:

```yml
TAIGA_PUBLIC_REGISTER_ENABLED=false
TAIGA_PUBLIC_REGISTER_ENABLED=true
TAIGA_PUBLIC_REGISTER_ENABLED=
```

### TAIGA_SUPPORT_URL

_Default value_: `https://tree.taiga.io/support`

Taiga frontend support URL.

Examples:

```yml
TAIGA_SUPPORT_URL=https://tree.taiga.io/support
TAIGA_SUPPORT_URL=https://taiga.company.com/support
TAIGA_SUPPORT_URL=
```

### TAIGA_PRIVACY_POLICY_URL

_Default value_:

Taiga frontend privacy policy URL.

Examples:

```yml
TAIGA_PRIVACY_POLICY_URL=https://taiga.io/privacy-policy.html
TAIGA_PRIVACY_POLICY_URL=https://taiga.company.com/privacy-policy
TAIGA_PRIVACY_POLICY_URL=
```

### TAIGA_TOS_URL

_Default value_:

Taiga frontend terms of services URL.

Examples:

```yml
TAIGA_TOS_URL=https://taiga.io/terms-of-service.html
TAIGA_TOS_URL=https://taiga.company.com/terms-of-service
TAIGA_TOS_URL=
```

### TAIGA_GDPR_URL

_Default value_:

Taiga frontend GDPR compliance URL.

Examples:

```yml
TAIGA_GDPR_URL=https://taiga.io/gdpr-compliance.html
TAIGA_GDPR_URL=https://taiga.company.com/gdpr-compliance
TAIGA_GDPR_URL=
```

### TAIGA_MAX_UPLOAD_SIZE

_Default value_: `104857600` (100 Mo)

Taiga frontend max file upload size.

Examples:

```yml
TAIGA_MAX_UPLOAD_SIZE=104857600
TAIGA_MAX_UPLOAD_SIZE=20480
TAIGA_MAX_UPLOAD_SIZE=
```

### TAIGA_CONTRIB_PLUGINS

_Default value_:

Taiga frontend plugins installed. Remember to install and configure your plugins in the backend too.

Examples:

```yml
TAIGA_CONTRIB_PLUGINS=slack
TAIGA_CONTRIB_PLUGINS='slack call-to-action cookie-warning'
TAIGA_CONTRIB_PLUGINS=
```

### TAIGA_IMPORTERS

_Default value_:

Taiga frontend importers installed (only for Taiga < 6.0). Remember to enable importers in the backend too.

Examples:

```yml
TAIGA_IMPORTERS=github
TAIGA_IMPORTERS='github jira trello asana'
TAIGA_IMPORTERS=
```

### TAIGA_IMPORTER_GITHUB_ENABLED

_Default value_: `false`

Enable Taiga [GitHub](https://github.com) importer (only for Taiga >= 6.0). Remember to enable it in the backend too.

Examples:

```yml
TAIGA_IMPORTER_GITHUB_ENABLED=false
```

```yml
TAIGA_IMPORTER_GITHUB_ENABLED=true
```

### TAIGA_IMPORTER_TRELLO_ENABLED

_Default value_: `false`

Enable Taiga [Trello](https://trello.com/) importer (only for Taiga >= 6.0). Remember to enable it in the backend too.

Examples:

```yml
TAIGA_IMPORTER_TRELLO_ENABLED=false
```

```yml
TAIGA_IMPORTER_TRELLO_ENABLED=true
```

### TAIGA_IMPORTER_JIRA_ENABLED

_Default value_: `false`

Enable Taiga [JIRA](https://www.atlassian.com/software/jira) importer (only for Taiga >= 6.0). Remember to enable it in the backend too.

Examples:

```yml
TAIGA_IMPORTER_JIRA_ENABLED=false
```

```yml
TAIGA_IMPORTER_JIRA_ENABLED=true
```

### TAIGA_IMPORTER_ASANA_ENABLED

_Default value_: `false`

Enable Taiga [Asana](https://asana.com) importer (only for Taiga >= 6.0). Remember to enable it in the backend too.

Examples:

```yml
TAIGA_IMPORTER_ASANA_ENABLED=false
```

```yml
TAIGA_IMPORTER_ASANA_ENABLED=true
```

### TAIGA_GRAVATAR

_Default value_: `true`

Enable Taiga Gravatar usage for usage profile pictures.

Examples:

```yml
TAIGA_GRAVATAR=false
TAIGA_GRAVATAR=true
TAIGA_GRAVATAR=
```

### TAIGA_LOGIN_FORM_TYPE

_Default value_: `normal`

Taiga frontend login form type.

Examples:

```yml
TAIGA_LOGIN_FORM_TYPE=normal
TAIGA_LOGIN_FORM_TYPE=
```

### TAIGA_BACK_HOST

_Default value_: `taigaback`

Taiga backend host for Nginx proxy.

Examples:

```yml
TAIGA_BACK_HOST=taigaback
TAIGA_BACK_HOST=back
TAIGA_BACK_HOST=taiga_back
```

### TAIGA_BACK_PORT

_Default value_: `8001`

Taiga backend port for Nginx proxy.

Examples:

```yml
TAIGA_BACK_PORT=8001
TAIGA_BACK_PORT=18000
```

### TAIGA_EVENTS_ENABLED

_Default value_:

Enable Taiga events. Remember to enable it in the backend too.

Examples:

```yml
TAIGA_EVENTS_ENABLED=1
TAIGA_EVENTS_ENABLED=True
TAIGA_EVENTS_ENABLED=
```

### TAIGA_EVENTS_HOST

_Default value_: `taigaevents`

Taiga events host for Nginx proxy.

Examples:

```yml
TAIGA_EVENTS_HOST=taigaevents
TAIGA_EVENTS_HOST=events
TAIGA_EVENTS_HOST=taiga_events
```

### TAIGA_EVENTS_PORT

_Default value_: `8888`

Taiga events port for Nginx proxy.

Examples:

```yml
TAIGA_EVENTS_PORT=8443
TAIGA_EVENTS_PORT=18888
```

---

[uri_license]: http://www.gnu.org/licenses/agpl.html

[uri_license_image]: https://img.shields.io/badge/License-AGPL%20v3-blue.svg

