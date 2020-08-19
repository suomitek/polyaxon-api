#!/bin/bash
set -e
set -o pipefail

if [[ -z "${POLYAXON_DB_NO_CHECK}" ]] ; then
/polyaxon/platform/scripts/all/check.sh
fi
if [[ -z "${POLYAXON_MANAGE}" ]] ; then
./web/start.sh
else
./manage/start.sh $*
fi
