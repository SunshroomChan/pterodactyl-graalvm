#!/bin/sh

# Copyright (c) 2021 Matthew Penner
# MIT License

# Default the TZ environment variable to UTC if not set.
[ -z "$TZ" ] && TZ="UTC"
export TZ

# Get internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2); exit}')
export INTERNAL_IP

# Change to the container's working directory
cd /home/container || exit 1

# Print Java version
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mjava -version\n"
java -version

# Replace {{VAR}} with ${VAR} and evaluate
PARSED=$(echo "$STARTUP" | sed -e 's/{{/${/g' -e 's/}}/}/g')
PARSED_EVAL=$(eval echo "$PARSED")

# Show and run the command
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED_EVAL"
# shellcheck disable=SC2086
eval $PARSED_EVAL