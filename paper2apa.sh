#!/usr/bin/env bash
# name: paper2apa
#  ver: v0.0
# date: 2024/04/03
# desc: Get APA formatted citation from DOI.
# auth: Carlos Vigil-Vásquez
# deps: curl
#  lic: Permission to copy and modify is granted under the MIT license
#   cc: Copyright (C) 2024 Carlos Vigil-Vásquez (carlos.vigil.v@gmail.com)

set -eo pipefail
if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

# Helper functions
function usage() {
	echo "Usage: paper2citation <doi> <style>"
}

function help_message() {
	echo "
Get formatted citation from PDF.

Common styles:
  - apa
  - american-chemical-society
  - bibtex
  - chicago-annotated-bibliography
  - nature

For all available citation styles, refer to
<https://github.com/citation-style-language/styles>.
"
}

function ensure_dependency() {
	local tool=$1
	if ! command -v "${tool}" &>/dev/null; then
		echo "Error: $tool not installed" >&2
		exit 1
	fi
}

function get_doi_from_pdf() {
	local pdf="$1"
	local doi

	# Extract DOI from PDF file
	doi=$(pdfinfo "${pdf}" | grep -io "doi:.*" -m 1) ||
		doi=$(pdftotext "${pdf}" - 2>/dev/null | grep -io "doi:.*" -m 1)
	if [ -n "${doi}" ]; then
		echo "${doi/doi:/}"
	else
		echo "DOI not found in $1"
		exit 1
	fi
}

function parse_doi() {
	local doi=$1
	local style=$2
	local citation

	# Add URL prefix if missing
	if [[ "${doi}" != *"https://doi.org/"* ]]; then
		doi="https://doi.org/${doi}"
	fi

	# Get citation using DOI Context Negotiation
	citation=$(curl -LH "Accept: text/x-bibliography; style=${style}" -w "\\n" "${doi}" 2>/dev/null)
	if [ -n "${citation}" ]; then
		echo "${citation}"
	fi
}

main() {
	cd "$(dirname "$0")"
	>&2 echo "paper2citation - v0.0"

	if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
		usage
		help_message
		exit
	elif [ $# -ne 2 ]; then
		usage
		exit
	fi

	ensure_dependency "curl"

	if [ -f "$1" ]; then
		doi=$(get_doi_from_pdf "${1}")
		parse_doi "${doi}" "${2}"
	else
		echo "[ERROR] Input must be a file!"
		exit 1
	fi
}

main "$@"
