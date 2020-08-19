/polyaxon/platform/scripts/all/create_user.sh
if [[ -z "${POLYAXON_SECURITY_CONTEXT_USER}" ]] || [[ -z "${POLYAXON_SECURITY_CONTEXT_GROUP}" ]]; then
    python3 polyaxon/manage.py $*
else
    gosu polyaxon python3 polyaxon/manage.py $*
fi
