#!/usr/bin/env bash
#
# Run helper script
# Version: 1.0

set -euo pipefail
IFS=$'\n\t'

readonly __command_prefix='cmd'

_command_from_args() {
  local command="${__command_prefix}"
  if [[ -z "${1:-}" ]]; then
      command="${command}_default"
  else
    for d in "$@"; do
      command="${command}_${d}"
    done
  fi
  echo "${command}"
}

_command_execute() {
  local cmd_fun
  cmd_fun="$(_command_from_args "$@")"
  if [[ "$(type -t "${cmd_fun}")" != 'function' ]]; then
    cmd_fun="$(_command_from_args "$@" 'help')"
  fi
  _command_execute_silent "${cmd_fun}_pre"
  ${cmd_fun} "$@"
  _command_execute_silent "${cmd_fun}_post"
}

_command_execute_silent() {
  if [[ "$(type -t "$1")" == 'function' ]]; then
    $1
  fi
}

cmd_help() {
  echo "Usage: $0 "
}

main() {
  _command_execute "$@"
}