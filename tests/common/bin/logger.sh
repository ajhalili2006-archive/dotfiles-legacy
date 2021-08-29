#!/bin/bash

LOGGER_TARGET_FILE="/var/tests/exec-log.txt"

if [[ $LOG_EVERYTHING == "" || $LOG_EVERYTHING == "false" ]]; then
  exec "$@"
fi

# based on https://gitlab.com/friendly-telegram/friendly-telegram/-/blob/master/install.sh#L43-49, but a bit modified
# for our use case
log() {
  # Runs the arguments and spins once per line of stdout (tee'd to logfile), also piping stderr to logfile
  { "$@" 2>>$LOGGER_TARGET_FILE || return $?; } | while read -r line; do
    spin
    printf "%s\n" "$line" >> $LOGGER_TARGET_FILE
  done
}

log "$@"
