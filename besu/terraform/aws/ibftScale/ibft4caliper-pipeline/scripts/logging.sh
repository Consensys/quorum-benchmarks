#!/usr/bin/env bash

function log_info() {
    echo "INFO: $(date -Iseconds) - $@"
}

function log_error() {
    echo -e "\e[31mERROR\e[0m: $(date -Iseconds) - $@" >&2
}

