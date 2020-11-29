#!/usr/bin/env bash

# Failing commands cause the script to exit immediately
set -e
# Errors on undefined variables
set -u
# Don't hide errors in pipes
set -o pipefail

# Colours
clr_clear=$(tput sgr0)
clr_white=$(tput setaf 7)
clr_red=$(tput setaf 1)
clr_yellow=$(tput setaf 3)
clr_blue=$(tput setaf 4)
clr_green=$(tput setaf 2)
clr_magenta=$(tput setaf 5)
clr_cyan=$(tput setaf 6)

debug_mode=0
_debug() {
    # _debug "${FUNCNAME[0]}" ""
    if (( "${debug_mode}" == 0)); then
        printf "${clr_blue}[DEBUG]\t ${clr_yellow}$(date +%T) ${clr_cyan}%s ${clr_magenta}- ${clr_white}%s${clr_clear}\n" "${1}" "${2}"
    fi
}

_info() {
    # _info "${FUNCNAME[0]}" ""
    printf "${clr_green}[INFO]\t ${clr_yellow}$(date +%T) ${clr_cyan}%s ${clr_magenta}- ${clr_white}%s${clr_clear}\n" "${1}" "${2}"
}

_error() {
    # _info "${FUNCNAME[0]}" ""
    printf "${clr_red}[ERROR]\t ${clr_yellow}$(date +%T) ${clr_cyan}%s ${clr_magenta}- ${clr_white}%s${clr_clear}\n" "${1}" "${2}"
}

main() {
    _info "${FUNCNAME[0]}" "Building docker image 'ayo_ta' from current directory."
    docker build -t "ayo_ta" .
    _info "${FUNCNAME[0]}" "Image build completed."
    docker images "ayo_ta"
}

main "${@}"