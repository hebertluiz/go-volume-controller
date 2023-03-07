#!/bin/bash

### Basic go compilation for arch

OS_NAME="$(uname -s)"

DEFAULT_ARCH='amd64'
DEFAULT_OS="${OS_NAME,,}"

function usage () {
    cat << EOF
Basic script for go cross compilation.
Usage: $0 <TARGET_ARCH> <SOURCE_FILE> <TARGET_BINARY>

EOF

}


function compile () {
    if [ ! -f "$1" ]; then
        printf 'File not found: %s\n' "$1" >&2
        return 1
    fi

    if [ -f "$2" ]; then
        printf 'Output file already exists: %s\n' "$2" >&2
        read -n 1 -rep 'Overwrite the file? (Y/n) '

        if [ "${REPLY,,}" = 'n' ];then
            printf '\nAborted.\n\n' >&2
   
            return 1 
        fi
        
        GOOS=${TARGET_OS:-${DEFAULT_OS}} \
            GOARCH=${TARGET_ARCH:-${DEFAULT_ARCH}} \
            go build -o "$2" "$1"

        return $?

    fi

}


function main () {

    if [ $# -lt 3 ]; then
        printf 'Insuficient arguments.\n\n'
        usage >&2
        exit 1
    fi

    
}

main "$@"