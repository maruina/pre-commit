#!/bin/bash

set -e

for file in "$@"; do

    # We are using the md5sum to check if the file is changing before and after the formatting
    # because jsonnetfmt doesn't have a different exit code to differentiate.  

    before=$(md5 -q "${file}")
    jsonnetfmt -i "${file}"
    after=$(md5 -q "${file}")

    if [[ ${after} != "${before}" ]]; then
        echo "Fixing ${file}"
    fi
done
