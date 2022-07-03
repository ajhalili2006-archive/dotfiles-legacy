#!/usr/bin/env bash
# Library code for the bootstrap scripts

# Adding colors to some text in termnial based on checks
if [ -t 1 ] && [[ "$NO_COLOR" == "" ]]; then
  RED=$(printf '\033[31m')
  GREEN=$(printf '\033[32m')
  YELLOW=$(printf '\033[33m')
  BLUE=$(printf '\033[34m')
  MAGENTA=$(printf '\033[35m')
  BOLD=$(printf '\033[1m')
  RESET=$(printf '\033[m')
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  MAGENTA=""
  BOLD=""
  RESET=""
fi