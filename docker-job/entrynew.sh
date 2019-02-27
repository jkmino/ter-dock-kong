#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

fixme() {
	if [ "$?" -eq "1" ]; then
		echo FIXME: Please send us what you found, contacto@bennu.cl.
  fi
}

run() {
	if [ "$1" == "HelloFromBennu" ]; then
		/bin/sh
  fi
}

trap fixme EXIT

msg=""
cat message |
while IFS= read -r line
do
	msg=$line
  run $msg
done

