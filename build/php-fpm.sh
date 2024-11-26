#!/bin/bash
source ./vars.sh
set -eux

cd $ENGINE_PATH


docker build -f $ENGINE_PATH/containers/php-fpm/Dockerfile.dev -t zebrah_php-fpm .

#run controller container
docker run --name zebrah_php-fpm -d -it --network=minds \
-v $FRONT_PATH:/var/www/Minds/front:cached \
-v $ENGINE_PATH:/var/www/Minds/engine:cached \
-v $SCRIPTS_FOLDER_PATH/../minds/cert/:/.dev \
--restart on-failure zebrah_php-fpm
