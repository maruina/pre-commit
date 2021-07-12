#!/bin/bash

set -e

if [[ "$OSTYPE" == "darwin"* ]]; then
    md5command="md5 -q"
else
    md5command="md5sum"
fi

for file in "$@"; do

    # We are using the md5sum to check if the file is changing before and after the formatting
    # because jsonnetfmt doesn't have a different exit code to differentiate.  

    before=$(eval "${md5command} ${file}")
    jsonnetfmt -i "${file}"
    after=$(eval "${md5command} ${file}")

    if [[ ${after} != "${before}" ]]; then
        echo "Fixing ${file}"
    fi
done
