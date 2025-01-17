#!/bin/sh

set -e
set +u

# Parse command-line options
. ./parseCMDOpts.sh "$@"

# Use defaults if not set
UNIX_SOCKET=""
if [ -z "${DEVICE_TELNET_PORT}" ]; then
    UNIX_SOCKET="true"
fi

if [ -z "${VALON_INSTANCE}" ]; then
   VALON_INSTANCE="Valon1"
fi

set -u

# Run run*.sh scripts with procServ
if [ "${UNIX_SOCKET}" ]; then
    /usr/local/bin/procServ -f -n ${VALON_INSTANCE} -i ^C^D unix:./procserv.sock ./runValon5009.sh "$@"
else
    /usr/local/bin/procServ -f -n ${VALON_INSTANCE} -i ^C^D ${DEVICE_TELNET_PORT} ./runValon5009.sh "$@"
fi
