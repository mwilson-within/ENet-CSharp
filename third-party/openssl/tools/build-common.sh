#!/bin/bash
#
# Copyright 2016 leenjewel
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Modified by Trevor Dasch to add realpath and remove unnecessary
# configuration steps for usage by ENet
#

export PLATFORM_TYPE=""

function realpath() {
    SOURCE="$1"
    while [ -h "$SOURCE" ]; do
        DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"        
    done
    REALPATH="$(cd -P "$(dirname "$SOURCE")" && pwd)"
    echo $REALPATH
}

function get_cpu_count() {
    if [ "$(uname)" == "Darwin" ]; then
        echo $(sysctl -n hw.physicalcpu)
    else
        echo $(nproc)
    fi
}

export bold_color="\033[1;m"
export warn_color="\033[33m"
export error_color="\033[31m"
export reset_color="\033[0m"
export ncols=80

function init_log_color() {
    true
}

function log_info() {
    printf "$warn_color$@$reset_color\n"
}

function log_warning() {
    printf "$warn_color$bold_color$@$reset_color\n"
}

function log_error() {
    printf "$error_color$bold_color$@$reset_color\n"
}

# init_log_color
# log_info "info"
# log_warning "warning"
# log_error "error"