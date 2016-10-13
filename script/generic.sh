#!/usr/bin/env bash

set -ex

# find generic installers and run them all interactively
find .. -name all.sh |
while read installer; do
  sh -c "${installer}" > /dev/null ;
done
