#!/bin/bash
set -e

thin start -p 3001

# Then exec the container's main process use CMD (what"s set as CMD in the Dockerfile).
exec "$@"
