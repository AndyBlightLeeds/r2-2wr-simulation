#!/bin/bash
# Start the docker container.
# set -x

docker_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"
. ${docker_dir}/vars.bash
CODE_DIR=${docker_dir}/..

mkdir -p ${WORKSPACE_DIR}
cp -f ${docker_dir}/../setup/*.bash ${WORKSPACE_DIR}
cp -f ${docker_dir}/../vars.bash ${WORKSPACE_DIR}

docker container inspect ${CONTAINER_NAME} &> /dev/null
if [ $? == 0 ]
then
    # Container exists.
    if [ "$( docker container inspect -f '{{.State.Status}}' ${CONTAINER_NAME} )" == "running" ]
    then
        # Container is running.
        echo "Container '${CONTAINER_NAME}' is already running."
    else
        # Container exists but is not running.
        docker container start ${CONTAINER_NAME} &> /dev/null
        echo "Container '${CONTAINER_NAME}' started."
    fi
else
    # Container does not exist.
    mkdir -p ${WORKSPACE_DIR}
    # Setup X window for the container to use.
    XAUTH=/tmp/.docker.xauth
    if [ ! -f $XAUTH ]
    then
        xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
        if [ ! -z "$xauth_list" ]
        then
            echo $xauth_list | xauth -f $XAUTH nmerge -
        else
            touch $XAUTH
        fi
        chmod a+r $XAUTH
    fi

    docker container run \
        --detach \
        --tty \
        --net=host \
        --env="DISPLAY=$DISPLAY" \
        --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
        --volume $HOME/Arduino:/home/build/Arduino \
        --device /dev/ttyUSB0:/dev/ttyUSB0 \
        --name ${CONTAINER_NAME} \
        ${DOCKER_HUB_USER_NAME}/${IMAGE_NAME}:${IMAGE_TAG} &> /dev/null
    if [ $? == 0 ]
    then
        echo "Container '${CONTAINER_NAME}' running."
    else
        echo "Container '${CONTAINER_NAME}' failed."
    fi
fi
