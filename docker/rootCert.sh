#!/bin/sh
set -e

cp /root/.local/share/mkcert/* /rootCert
chown $USER_ID:$GROUP_ID -R /rootCert

exec /entrypoint.sh "$@"
