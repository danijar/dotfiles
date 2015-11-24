#!/bin/sh
REPOSITORY=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/..
pacman -Qe > ${REPOSITORY}/backup/package-list
