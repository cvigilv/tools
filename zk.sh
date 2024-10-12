#!/usr/bin/env bash
#title           :zk
#description     :Open Zettelkasten inside tmux session
#author          :Carlos Vigil Vásquez
#date            :20240109
#version         :v20240109a
#copyright       :Copyright (C) 2024 Carlos Vigil Vásquez (carlos.vigil.v@gmail.com)
#license         :Permission to copy and modify is granted under the MIT license

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./zk

Open Zettelkasten inside tmux session

'
	exit
fi

cd "$(dirname "$0")"

main() {

}

main "$@"
