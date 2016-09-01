#!/usr/bin/env bash
BASEDIR=$(dirname "$0")
docker build --rm -t plex $BASEDIR
