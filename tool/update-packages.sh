#!/bin/sh
REPOSITORY=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/..
pacman -Qqe > ${REPOSITORY}/backup/package-list
