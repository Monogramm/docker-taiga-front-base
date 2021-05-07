#!/bin/sh
set -e

log() {
  echo "[$(date +%Y-%m-%dT%H:%M:%S%:z)] $*"
}

if [ ! -f /taiga/conf.json ]; then
  log "Missing Taiga frontend configuration!"
  exit 1
fi

#########################################
## Taiga Front custom config
#########################################
if [ -f /custom_init.sh ]; then
  log "Importing custom init script..."
  . /custom_init.sh
fi

#########################################
## Taiga Front config
#########################################

# Automatically replace "TAIGA_HOSTNAME" with the environment variable
sed -i "s|TAIGA_HOSTNAME|${TAIGA_HOSTNAME:-$TAIGA_SITES_DOMAIN}|g" /taiga/conf.json

# Look to see if we should set the "eventsUrl"
if [ -n "${TAIGA_EVENTS_ENABLED:-$EVENTS_ENABLED}" ]; then
  log "Enabling Taiga Events"
  sed -i \
    -e "s|\"eventsUrl\": .*,|\"eventsUrl\": \"ws://${TAIGA_HOSTNAME:-$TAIGA_SITES_DOMAIN}/events\",|g" \
    /taiga/conf.json
else
  log "Reset Taiga Events"
  sed -i \
    -e "s|\"eventsUrl\": .*,|\"eventsUrl\": null,|g" \
    /taiga/conf.json
fi

# Handle enabling/disabling SSL
if [ "${TAIGA_SSL_BY_REVERSE_PROXY}" = "True" ]; then
  log "Enabling external SSL support! SSL handling must be done by a reverse proxy or a similar system"
  sed -i \
    -e "s|http://|https://|g" \
    -e "s|ws://|wss://|g" \
    /taiga/conf.json
elif [ "${TAIGA_SSL}" = "True" ]; then
  log "Enabling SSL support!"
  sed -i \
    -e "s|http://|https://|g" \
    -e "s|ws://|wss://|g" \
    /taiga/conf.json
elif grep -q "wss://" "/taiga/conf.json"; then
  log "Disabling SSL support!"
  sed -i \
    -e "s|https://|http://|g" \
    -e "s|wss://|ws://|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_DEBUG}" ]; then
  log "Updating Taiga Front debug status: ${TAIGA_DEBUG}"
  sed -i \
    -e "s|\"debug\": .*,|\"debug\": ${TAIGA_DEBUG},|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_DEBUG_INFO}" ]; then
  log "Updating Taiga Front debug info status: ${TAIGA_DEBUG_INFO}"
  sed -i \
    -e "s|\"debugInfo\": .*,|\"debugInfo\": ${TAIGA_DEBUG_INFO},|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_DEFAULT_LANGUAGE}" ]; then
  log "Updating Taiga Front default language: ${TAIGA_DEFAULT_LANGUAGE}"
  sed -i \
    -e "s|\"defaultLanguage\": \".*\"|\"defaultLanguage\": \"${TAIGA_DEFAULT_LANGUAGE}\"|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_THEMES}" ]; then
  log "Updating Taiga Front themes list: ${TAIGA_THEMES}"
  themes_list=
  for theme in ${TAIGA_THEMES} ; do
    themes_list="$themes_list\"$theme\", ";
  done
  sed -i \
    -e "s|\"themes\": \[.*\]|\"themes\": [${themes_list::-2}]|g" \
    /taiga/conf.json
else
  log "Reset Taiga Front themes list"
  sed -i \
    -e "s|\"themes\": \[.*\]|\"themes\": [\"taiga\"]|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_DEFAULT_THEME}" ]; then
  log "Updating Taiga Front default theme: ${TAIGA_DEFAULT_THEME}"
  sed -i \
    -e "s|\"defaultTheme\": \".*\"|\"defaultTheme\": \"${TAIGA_DEFAULT_THEME}\"|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_PUBLIC_REGISTER_ENABLED:-$PUBLIC_REGISTER_ENABLED}" ]; then
  log "Updating Taiga Front public registration status: ${TAIGA_PUBLIC_REGISTER_ENABLED:-$PUBLIC_REGISTER_ENABLED}"
  sed -i \
    -e "s|\"publicRegisterEnabled\": .*,|\"publicRegisterEnabled\": ${TAIGA_PUBLIC_REGISTER_ENABLED:-$PUBLIC_REGISTER_ENABLED},|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_FEEDBACK_ENABLED:-$FEEDBACK_ENABLED}" ]; then
  log "Updating Taiga Front feedback status: ${TAIGA_FEEDBACK_ENABLED:-$FEEDBACK_ENABLED}"
  sed -i \
    -e "s|\"feedbackEnabled\": .*,|\"feedbackEnabled\": ${TAIGA_FEEDBACK_ENABLED:-$FEEDBACK_ENABLED},|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_SUPPORT_URL:-$SUPPORT_URL}" ]; then
  log "Updating Taiga Front support URL: ${TAIGA_SUPPORT_URL:-$SUPPORT_URL}"
  sed -i \
    -e "s|\"supportUrl\": .*,|\"supportUrl\": \"${TAIGA_SUPPORT_URL:-$SUPPORT_URL}\",|g" \
    /taiga/conf.json
else
  log "Reset Taiga Front support URL"
  sed -i \
    -e "s|\"supportUrl\": .*,|\"supportUrl\": null,|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_PRIVACY_POLICY_URL:-$PRIVACY_POLICY_URL}" ]; then
  log "Updating Taiga Front privacy policy URL: ${TAIGA_PRIVACY_POLICY_URL:-$PRIVACY_POLICY_URL}"
  sed -i \
    -e "s|\"privacyPolicyUrl\": .*,|\"privacyPolicyUrl\": \"${TAIGA_PRIVACY_POLICY_URL:-$PRIVACY_POLICY_URL}\",|g" \
    /taiga/conf.json
else
  log "Reset Taiga Front privacy policy URL"
  sed -i \
    -e "s|\"privacyPolicyUrl\": .*,|\"privacyPolicyUrl\": null,|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_TOS_URL:-$TOS_URL}" ]; then
  log "Updating Taiga Front terms of services URL: ${TAIGA_TOS_URL:-$TOS_URL}"
  sed -i \
    -e "s|\"termsOfServiceUrl\": .*,|\"termsOfServiceUrl\": \"${TAIGA_TOS_URL:-$TOS_URL}\",|g" \
    /taiga/conf.json
else
  log "Reset Taiga Front terms of services URL"
  sed -i \
    -e "s|\"termsOfServiceUrl\": .*,|\"termsOfServiceUrl\": null,|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_GDPR_URL:-$GDPR_URL}" ]; then
  log "Updating Taiga Front GDPR compliance URL: ${TAIGA_GDPR_URL:-$GDPR_URL}"
  sed -i \
    -e "s|\"GDPRUrl\": .*,|\"GDPRUrl\": \"${TAIGA_GDPR_URL:-$GDPR_URL}\",|g" \
    /taiga/conf.json
else
  log "Reset Taiga Front GDPR compliance URL"
  sed -i \
    -e "s|\"GDPRUrl\": .*,|\"GDPRUrl\": null,|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_MAX_UPLOAD_SIZE:-$MAX_UPLOAD_SIZE}" ]; then
  log "Updating Taiga Front max upload file size: ${TAIGA_MAX_UPLOAD_SIZE:-$MAX_UPLOAD_SIZE}"
  sed -i \
    -e "s|\"maxUploadFileSize\": .*,|\"maxUploadFileSize\": ${TAIGA_MAX_UPLOAD_SIZE:-$MAX_UPLOAD_SIZE},|g" \
    /taiga/conf.json
else
  log "Reset Taiga Front GDPR URL"
  sed -i \
    -e "s|\"maxUploadFileSize\": .*,|\"maxUploadFileSize\": null,|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_CONTRIB_PLUGINS}" ]; then
  log "Updating Taiga Front contribution plugins list: ${TAIGA_CONTRIB_PLUGINS}"
  plugins_list=
  for plugin in ${TAIGA_CONTRIB_PLUGINS} ; do
    plugins_list="$plugins_list\"/plugins/$plugin/$plugin.json\", ";
  done
  sed -i \
    -e "s|\"contribPlugins\": \[.*\]|\"contribPlugins\": [${plugins_list::-2}]|g" \
    /taiga/conf.json
else
  log "Reset Taiga Front contribution plugins list"
  sed -i \
    -e "s|\"contribPlugins\": \[.*\]|\"contribPlugins\": []|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_IMPORTERS}" ]; then
  log "Updating Taiga Front importers list: ${TAIGA_IMPORTERS}"
  importers_list=
  for importer in ${TAIGA_IMPORTERS} ; do
    importers_list="$importers_list \"$importer\",";
  done
  sed -i \
    -e "s|\"importers\": [.*]|\"importers\": [${importers_list::-1}]|g" \
    /taiga/conf.json
else
  log "Reset Taiga Front importers list"
  sed -i \
    -e "s|\"importers\": [.*]|\"importers\": []|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_IMPORTER_GITHUB_ENABLED:-$ENABLE_GITHUB_IMPORTER}" ]; then
  log "Updating Taiga Front GitHub importer status: ${TAIGA_IMPORTER_GITHUB_ENABLED:-$ENABLE_GITHUB_IMPORTER}"
  sed -i \
    -e "s|\"enableGithubImporter\": .*,|\"enableGithubImporter\": ${TAIGA_IMPORTER_GITHUB_ENABLED:-$ENABLE_GITHUB_IMPORTER},|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_IMPORTER_JIRA_ENABLED:-$ENABLE_JIRA_IMPORTER}" ]; then
  log "Updating Taiga Front Jira importer status: ${TAIGA_IMPORTER_JIRA_ENABLED:-$ENABLE_JIRA_IMPORTER}"
  sed -i \
    -e "s|\"enableJiraImporter\": .*,|\"enableJiraImporter\": ${TAIGA_IMPORTER_JIRA_ENABLED:-$ENABLE_JIRA_IMPORTER},|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_IMPORTER_TRELLO_ENABLED:-$ENABLE_TRELLO_IMPORTER}" ]; then
  log "Updating Taiga Front Trello importer status: ${TAIGA_IMPORTER_TRELLO_ENABLED:-$ENABLE_TRELLO_IMPORTER}"
  sed -i \
    -e "s|\"enableTrelloImporter\": .*,|\"enableTrelloImporter\": ${TAIGA_IMPORTER_TRELLO_ENABLED:-$ENABLE_TRELLO_IMPORTER},|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_IMPORTER_ASANA_ENABLED:-$ENABLE_ASANA_IMPORTER}" ]; then
  log "Updating Taiga Front Asana importer status: ${TAIGA_IMPORTER_ASANA_ENABLED:-$ENABLE_ASANA_IMPORTER}"
  sed -i \
    -e "s|\"enableAsanaImporter\": .*,|\"enableAsanaImporter\": ${TAIGA_IMPORTER_ASANA_ENABLED:-$ENABLE_ASANA_IMPORTER},|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_GRAVATAR:-$ENABLE_GRAVATAR}" ]; then
  log "Updating Taiga Front Gravatar status: ${TAIGA_GRAVATAR:-$ENABLE_GRAVATAR}"
  sed -i \
    -e "s|\"gravatar\": .*,|\"gravatar\": ${TAIGA_GRAVATAR:-$ENABLE_GRAVATAR},|g" \
    /taiga/conf.json
fi

if [ -n "${TAIGA_LOGIN_FORM_TYPE:-$LOGIN_FORM_TYPE}" ]; then
  log "Updating Taiga Front login form type: ${TAIGA_LOGIN_FORM_TYPE:-$LOGIN_FORM_TYPE}"
  sed -i \
    -e "s|\"loginFormType\": \".*\"|\"loginFormType\": \"${TAIGA_LOGIN_FORM_TYPE:-$LOGIN_FORM_TYPE}\"|g" \
    /taiga/conf.json
else
  log "Reset Taiga Front login form type"
  sed -i \
    -e "s|\"loginFormType\": \".*\"|\"loginFormType\": \"normal\"|g" \
    /taiga/conf.json
fi

#########################################
## Taiga NGinx config
#########################################

# Reinitialize nginx links
if [ -d /etc/nginx/conf.d/ ]; then
  rm -f /etc/nginx/conf.d/*.conf
fi

if [ "${TAIGA_SSL}" = "True" ]; then
  if [ -n "${TAIGA_EVENTS_ENABLED:-$EVENTS_ENABLED}" ]; then
    ln -s \
      /etc/nginx/sites-available/taiga-events-ssl.conf \
      /etc/nginx/conf.d/taiga.conf
  else
    ln -s \
      /etc/nginx/sites-available/taiga-ssl.conf \
      /etc/nginx/conf.d/taiga.conf
  fi
else
  if [ -n "${TAIGA_EVENTS_ENABLED:-$EVENTS_ENABLED}" ]; then
    ln -s \
      /etc/nginx/sites-available/taiga-events.conf \
      /etc/nginx/conf.d/taiga.conf
  else
    ln -s \
      /etc/nginx/sites-available/taiga.conf \
      /etc/nginx/conf.d/taiga.conf
  fi
fi

# Update proxy pass if backend served with SSL
if [ "${TAIGA_BACKEND_SSL}" = "True" ]; then
  sed -i \
    -e "s|http://|https://|g" \
    /etc/nginx/snippets/api.conf
else
  sed -i \
    -e "s|https://|http://|g" \
    /etc/nginx/snippets/api.conf
fi

# Look to see if we should update the backend connection
if [ -n "${TAIGA_BACK_HOST}" ]; then
  log "Updating Taiga Back connection: ${TAIGA_BACK_HOST}"
  sed -i \
    -e "s|server .*;|server ${TAIGA_BACK_HOST}:${TAIGA_BACK_PORT:-8001};|g" \
    /etc/nginx/snippets/upstream.conf
fi

# Look to see if we should update the events connection
if [ -n "${TAIGA_EVENTS_HOST}" ]; then
  log "Updating Taiga Events connection: ${TAIGA_EVENTS_HOST}"
  sed -i \
    -e "s|proxy_pass http://.*/events|proxy_pass http://${TAIGA_EVENTS_HOST}:${TAIGA_EVENTS_PORT:-8888}/events|g" \
    /etc/nginx/snippets/events.conf
fi

log "Checking nginx configuration..."
nginx -t

log "Start nginx server..."
nginx -g "daemon off;"
