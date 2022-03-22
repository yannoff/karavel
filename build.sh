#!/bin/bash
#
# Karavel assets builder script
#

tar \
    --owner=yannoff \
    --group=yannoff \
    --mtime=now \
    -cjvf karavel.tbz2 \
    bin/ \
    docker-compose.yaml \
    docker-compose.{mysql,pgsql}.yaml \
    .env.example.docker \
    karavel/
