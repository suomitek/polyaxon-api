#!/bin/bash
set -e
set -o pipefail

if [[ -z "${POLYAXON_SECURITY_CONTEXT_USER}" ]] || [[ -z "${POLYAXON_SECURITY_CONTEXT_GROUP}" ]]; then
    echo "Use default user"
    mkdir -p /polyaxon/logs
else
    # add our user and group first to make sure their IDs get assigned consistently
    groupadd -g ${POLYAXON_SECURITY_CONTEXT_USER} -r polyaxon && useradd -r -m -g polyaxon -G 0 -u ${POLYAXON_SECURITY_CONTEXT_GROUP} polyaxon
    mkdir -p /polyaxon/logs
    chown -R polyaxon:polyaxon /polyaxon/*
    chown -R polyaxon:polyaxon /tmp/
fi
