#!/bin/bash

DATA_PATH=/data

# If $DATA_PATH/iptables/rules.v4 exists, then load it
if [ -f $DATA_PATH/iptables/rules.v4 ]; then
    iptables-restore < $DATA_PATH/iptables/rules.v4

    # If iptables-restore failed, then exit
    if [ $? -ne 0 ]; then
				echo "ERROR: iptables-restore failed"
				exit 1
		fi
fi

#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- haproxy "$@"
fi

if [ "$1" = 'haproxy' ]; then
	shift # "haproxy"
	# if the user wants "haproxy", let's add a couple useful flags
	#   -W  -- "master-worker mode" (similar to the old "haproxy-systemd-wrapper"; allows for reload via "SIGUSR2")
	#   -db -- disables background mode
	set -- haproxy -W -db "$@"
fi

exec "$@"
