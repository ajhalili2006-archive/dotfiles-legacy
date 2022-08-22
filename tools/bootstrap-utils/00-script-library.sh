#!/usr/bin/env bash
#shellcheck disable=SC2034
# Library code for the bootstrap scripts

# Adding colors to some text in termnial based on checks
# NO_COLOR: https://no-color.org/
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

error() {
  echo "${RED}error: $*${RESET}"
}

success() {
  echo "${GREEN}success: $*${RESET}"
}

warn() {
  echo "${YELLOW}warning: $*${RESET}"
}

info() {
  echo "${BOLD}info: $*${RESET}"
}

showStage() {
  echo "${BOLD}==> $*${RESET}"
}