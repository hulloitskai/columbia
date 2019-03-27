#!/usr/bin/env bash

## mksecret is a program that creates a generic "sealed secret" using the same
## command-line interface as `kubectl create secret generic`.

if ! command -v kubectl > /dev/null; then
  echo "'kubectl' is not installed" >&2 && \
  exit 1
fi

if ! command -v kubeseal > /dev/null; then
  echo "'kubeseal' is not installed" >&2 && \
  exit 1
fi

if [[ $# -lt 2 ]] || [[ $1 == "--help" ]] || [[ $1 == "-h" ]]; then
  echo "Usage: mksecret <name> (--from-file=<file> | --from-literial=<key>=<val> | --from-env-file=<file>)" >&2 && \
  echo "                       [--namespace=<name> | -n<name>]" >&2 && \
  exit 2
fi

kubectl create secret generic $@ --dry-run -o yaml | \
  kubeseal --cert=./cert.pem --format=yaml
