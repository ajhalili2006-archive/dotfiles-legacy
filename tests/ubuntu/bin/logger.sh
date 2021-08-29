#!/bin/bash

LOGGER_TARGET_FILE="/var/tests/exec-log.txt"

if [[ $LOG_EVERYTHING == "" || $LOG_EVERYTHING == "false" ]]; then
  exec "$@"
fi
