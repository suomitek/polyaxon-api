#!/bin/bash
set -e
set -o pipefail

cd ./polyaxon
while [ "$(python3 ./manage.py showmigrations --plan | grep '\[ \]\|^[a-z]' | grep '[  ]' -B 1)" ]; do echo "Preparing..."; sleep 10; done; echo "Running...";
