#!/bin/bash
set -o errexit -o nounset -o pipefail
command -v shellcheck >/dev/null && shellcheck "$0"

versions=(
  "0.11.0"
  "0.10.2"
  "0.10.1"
  "0.10.0"
)

PRE=$(grep -B 1000 "<\!-- BEGIN AUTOGEN -->" src/checksums.md)
POST=$(grep -A 1000 "<\!-- END AUTOGEN -->" src/checksums.md)

(
  echo "$PRE"
  echo ""
  for version in "${versions[@]}"; do
    tag="v$version"
    echo "### Version $version"
    echo ""
    echo "Source code: [nois-contracts@$tag](https://github.com/noislabs/nois-contracts/tree/$tag)"
    echo ""
    echo '```'
    curl -sS -L "https://github.com/noislabs/nois-contracts/releases/download/$tag/checksums.txt"
    echo '```'
    echo ""
  done
  echo "$POST"
) > src/checksums.md
