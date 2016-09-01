#!/bin/bash

docker run --restart=always -d -h VEGETA --name plex -v /docker-data/plex:/var/lib/plexmediaserver -v /poolmirror1/:/poolmirror1/ -v /poolmirror2/:/poolmirror2/ -p 32400:32400 plex
