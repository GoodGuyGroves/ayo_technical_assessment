#!/usr/bin/env bash

# Failing commands cause the script to exit immediately
set -e
# Errors on undefined variables
set -u
# Don't hide errors in pipes
set -o pipefail

debug_mode=0
_debug() {
    # _debug "${FUNCNAME[0]}" ""
    if (( "${debug_mode}" == 0)); then
        printf "[DEBUG]\t $(date +%T) %s - %s\n" "${1}" "${2}"
    fi
}

_info() {
    # _info "${FUNCNAME[0]}" ""
    printf "[INFO]\t $(date +%T) %s - %s\n" "${1}" "${2}"
}

_error() {
    # _info "${FUNCNAME[0]}" ""
    printf "[ERROR]\t $(date +%T) %s - %s\n" "${1}" "${2}"
}

main() {
    _info "${FUNCNAME[0]}" "Building docker image 'ayo_ta' from current directory."
    docker build -t "ayo_ta" .
    _info "${FUNCNAME[0]}" "Image build completed."
    docker images "ayo_ta"
}

main "${@}"