#!/bin/bash
set -e
set -o pipefail

polyaxon proxy api
export POLYAXON_IS_OPS=false
rm -f /etc/nginx/sites-enabled/default
rm -f /etc/nginx/sites-available/default
mkdir -p /etc/nginx/polyaxon
/polyaxon/platform/scripts/all/create_user.sh
mv web/uwsgi_params /etc/nginx/uwsgi_params
mv web/polyaxon.main.conf /etc/nginx/sites-available/polyaxon.config
mv web/polyaxon.base.conf /etc/nginx/polyaxon/polyaxon.base.conf
ln -s /etc/nginx/sites-available/polyaxon.config /etc/nginx/sites-enabled/polyaxon.conf
nginx -c /etc/nginx/nginx.conf -t
service nginx restart
service nginx status
if [[ "${POLYAXON_LOG_LEVEL}" == "DEBUG" ]] || [[ "${POLYAXON_LOG_LEVEL}" == "INFO" ]]; then
    export DISABLE_LOGGING=false
else
    export DISABLE_LOGGING=true
fi

if [[ -z "${POLYAXON_SECURITY_CONTEXT_USER}" ]] || [[ -z "${POLYAXON_SECURITY_CONTEXT_GROUP}" ]]; then
    uwsgi --ini web/uwsgi.nginx.ini
else
    gosu polyaxon uwsgi --ini web/uwsgi.nginx.ini
fi
service nginx stop
service nginx status
