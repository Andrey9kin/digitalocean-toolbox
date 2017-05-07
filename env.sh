IMAGE=${IMAGE:-andrey9kin/digitalocean-toolbox:latest}
DIGITALOCEAN_ACCESS_TOKEN=${DIGITALOCEAN_ACCESS_TOKEN:-none}

docker run --rm \
           -it \
           -v ${HOME}:/home/$(whoami) \
           -e USER_ID=$(id -u) \
           -e GROUP_ID=$(id -g) \
           -e USER_NAME=$(whoami) \
           -e DIGITALOCEAN_ACCESS_TOKEN=${DIGITALOCEAN_ACCESS_TOKEN} \
           ${IMAGE} bash
