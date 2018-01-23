#!/bin/bash

docker run -d \
    -p 42068:42068 \
    -p 42069:42069 \
    -v "$(pwd)/wallet":/root/.garlicoin \
    --restart=always \
    --name garlicoin \
    my-garlicoin:latest
