#!/bin/bash

set -e

for file in "$@"; do
    jsonnetfmt -i "${file}"
done
