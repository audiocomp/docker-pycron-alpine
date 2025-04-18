set -ex
USERNAME=audiocomp
IMAGE=pycron
CONFIG=/home/steve/temp
SHARE=/home/steve/docker_test
docker run -it --rm --name $IMAGE -v $CONFIG:/work -v $SHARE:/share $USERNAME/$IMAGE
