#!/usr/bin/env bash

# Failing commands cause the script to exit immediately
set -e
# Errors on undefined variables
set -u
# Don't hide errors in pipes
set -o pipefail

# Needed for TERM-less envs so the script can use tput
export TERM=xterm

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

check_depends() {
    type jq > /dev/null 2>&1 || {
        _error "${FUNCNAME[0]}" "This script requires command line tool 'jq' to be installed but it is not.";
        _error "${FUNCNAME[0]}" "Please run 'sudo apt install -y jq' to install jq.";
        exit 1
    }
}

_getopts() {

    # Uncomment if the script should not be run without any parameters
    # set +u
    # if [[ -z "${1}" ]]; then
    #     _help
    # fi
    # set -u

    # The leading colon turns on silent error reporting
    # The trailing colon checks for a parameter
    while getopts ":a:e:vh" opt; do
        case "${opt}" in
            a)
                ACTION="${OPTARG,,}"
                _debug "${FUNCNAME[0]}" "Action set to: ${ACTION}"
                ;;
            e)
                ENV_PREFIX="${OPTARG}"
                _debug "${FUNCNAME[0]}" "Environment prefix set to: ${ENV_PREFIX}"
                ;;
            v)
                debug_mode=0
                _debug "${FUNCNAME[0]}" "Debug mode turned on"
                ;;
            h)
                _help
                exit 0
                ;;
            \?)
                _error "${FUNCNAME[0]}" "Invalid option: -${OPTARG}"
                _usage
                exit 1
                ;;
            :)
                printf "Option -%s requires an argument.\n" "${OPTARG}"
                _error "${FUNCNAME[0]}" "Option -${OPTARG} requires an argument."
                _usage
                exit 1
                ;;
            *)
                _help
                exit 1
                ;;
        esac
    done
    shift $((OPTIND -1))

    # if [[ "${ACTION}" != "start" ]] || [[ "${ACTION}" != "stop" ]] || [[ "${ACTION}" != "restart" ]]; then
    #     _error "${FUNCNAME[0]}" "Option -a can only be start, stop or restart"
    #     _help
    #     exit 1
    # fi
}

_usage() {
    printf "%s\n" "Usage: $0 [-a <start>/<stop>/<restart>] [-e <environment name>] [-v] [-h]" 1>&2
}

_help() {
    _usage
    printf "%s\t-\t%s\n" "-a" "(Optional) Action to perform: start, stop or restart. Defaults to start."
    printf "%s\t-\t%s\n" "-r" "(Optional) Environment name to use. Defaults to 'ayo_ta'."
    printf "%s\t-\t%s\n" "-v" "(Optional) Enables verbose logging."
    printf "%s\t-\t%s\n" "-h" "(Optional) This help."
}

main() {
    check_depends

    ENV_PREFIX="ayo_ta"
    ACTION="start"

    _getopts "${@}"

    if [[ "${ACTION}" == "stop" ]] || [[ "${ACTION}" == "restart" ]]; then
        if [[ -n $(docker-compose -p ${ENV_PREFIX} ps -q) ]]; then
            _info "${FUNCNAME[0]}" "Stopping environment"
            docker-compose -p ${ENV_PREFIX} down --remove-orphans
        fi

        mapfile -t containers < <(docker container ls --filter name=${ENV_PREFIX} --format "{{json .}}" | jq -r ".ID")
        if [[ "${containers:+set}" = set ]]; then
            _info "${FUNCNAME[0]}" "Found ${ENV_PREFIX} containers still running, stopping them individually"
            for container in "${containers[@]}"; do
                _info "${FUNCNAME[0]}" "Shutting down container: ${container}"
                docker ps --filter id="${container}"
                docker container stop "${container}"
                docker container rm "${container}"
            done
        fi
    fi

    # mapfile -t volumes < <(docker volume ls --filter name=${ENV_PREFIX} --format "{{json .}}" | jq -r ".Name")
    # if [[ "${volumes:+set}" = set ]]; then
    #     _info "${FUNCNAME[0]}" "Removing volumes for env ${ENV_PREFIX}"
    #     for volume in "${volumes[@]}"; do
    #         _info "${FUNCNAME[0]}" "Removing volume: ${volume}"
    #         docker volume rm "${volume}" > /dev/null 2>&1
    #     done
    # fi

    if [[ "${ACTION}" == "start" ]] || [[ "${ACTION}" == "restart" ]]; then
        _info "${FUNCNAME[0]}" "Starting environment ${ENV_PREFIX}"
        docker-compose -p ${ENV_PREFIX} up -d

        _info "${FUNCNAME[0]}" "Listing all running containers"
        docker-compose -p ${ENV_PREFIX} ps
    fi

    _info "${FUNCNAME[0]}" "Finished!"

}

main "${@}"