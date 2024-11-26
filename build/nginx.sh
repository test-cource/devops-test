#!/bin/bash
source ./vars.sh
set -eux

cd $CONTAINERS_PATH/nginx

docker build -f $CONTAINERS_PATH/nginx/Dockerfile.dev-ssr -t zebrah_nginx .

#run controller container
docker run --name zebrah_nginx -p 8080:80 -p 443:443 -d -it --network=minds \
-v $CONTAINERS_PATH/nginx/:/nginx \
-v $SCRIPTS_FOLDER_PATH/../minds/cert/:/ssl/key/ \
-e UPSTREAM_ENDPOINT="127.0.0.1:4200" \
--restart on-failure zebrah_nginx 
#/bin/bash/ /nginx_entrypoint_dev.sh
