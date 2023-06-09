#!/bin/sh

env

NODE_ARCH=""

case "${TARGETPLATFORM:-linux/amd64}" in
    "linux/amd64")   NODE_ARCH="x64" ;;
    "linux/arm64")   NODE_ARCH="arm64" ;;
    "linux/arm/v7")  NODE_ARCH="armv7" ;;
esac;

echo platform ${NODE_ARCH};

pkg index.js --targets node18-linux-${NODE_ARCH} --compress GZip 

ls -l
