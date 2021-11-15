#!/bin/bash
#
# Laradoc assets builder script
#

tar \
    --owner=yannoff \
    --group=yannoff \
    --mtime=now \
    -cjvf laradoc.tbz2 \
    bin/ \
    docker-compose.yaml \
    docker-compose.{mysql,pgsql}.yaml \
    .env.example.docker \
    laradoc/
