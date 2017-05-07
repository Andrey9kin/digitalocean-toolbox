# Why? What? How?
Image with preinstalled tools for working with DO so I don't need to install them locally
Container will be started with the same user name/user id/group id and home directory mapped to container as a volume

# Running local build
docker build -t toolbox .
DIGITALOCEAN_ACCESS_TOKEN="tocken" IMAGE="toolbox:latest" bash env.sh

# Running pre-build version from Docker Hub
DIGITALOCEAN_ACCESS_TOKEN="tocken" bash env.sh
