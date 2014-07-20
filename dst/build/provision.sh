#!/usr/bin/env bash
PLAYBOOK="$1"
shift
ARGS="$@"
/usr/local/bin/ansible-playbook bundle/${PLAYBOOK}.yml -c local -i '127.0.0.1,' --extra-vars="dst_username=vagrant" "$ARGS"
