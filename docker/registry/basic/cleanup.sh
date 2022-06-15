#!/bin/bash

# REGISTRY_STORAGE_DELETE_ENABLED=true
REGISTRY_URL=https://localhost:1000
### host registry volume folder
#REGISTRY_ROOT=/registry
REGISTRY_ROOT=/var/lib/registry
REGISTRY_VOLUMEN_ROOT=./vol-registry/registry
### container to execute garbage-collect
CONTAINER_NAME=registry
### config file used by your registry
REG_CONFIG=/etc/docker/registry/config.yml
### number of most recent digests to keep
NUM_DIGEST_KEEP=3
### tag to check
TAG=latest

#if ! [ -r $REGISTRY_ROOT ]; then
#    echo registry root $REGISTRY_ROOT not readable
#    exit;
#fi

echo "*** Check Container Name ***"
CONTAINER=`docker ps | grep $CONTAINER_NAME | cut -d' ' -f1`
if [ -z $CONTAINER ]; then
    echo container $CONTAINER_NAME not found
    exit 1
fi


echo "*** Check Volumen ***"
for repo in `ls $REGISTRY_VOLUMEN_ROOT/docker/registry/v2/repositories` ; do
    echo "* REPO"
    echo $repo
    echo "* Prepare delete repo"
    #for hash in `ls $REGISTRY_VOLUMEN_ROOT/docker/registry/v2/repositories/$repo/_manifests/tags/$TAG/index/sha256 -t | tail -n +$NUM_DIGEST_KEEP`; do
    for hash in `ls $REGISTRY_VOLUMEN_ROOT/docker/registry/v2/repositories/$repo/_manifests/tags/$TAG/index/sha256 -t`; do
        echo "DELETE HASH"
        echo $hash
        curl -vk -X DELETE $REGISTRY_URL/v2/$repo/manifests/sha256:$hash;
    done
done

#
#Usage: 
#  registry garbage-collect <config> [flags]
#Flags:
#  -m, --delete-untagged=false: delete manifests that are not currently referenced via tag
#  -d, --dry-run=false: do everything except remove the blobs
#  -h, --help=false: help for garbage-collect

echo "Prepare Garbage Collect"
# docker exec $CONTAINER bin/registry garbage-collect $REG_CONFIG -m
docker exec $CONTAINER /bin/registry garbage-collect $REG_CONFIG -m --dry-run 