TAGNAME=$(git describe)
if [[ $# -eq 1 ]] ; then
    TAGNAME=$1
fi

docker image build . --force-rm -f ./docker/app-room.Dockerfile -t "vidconf-ion_app-room:latest" -t "vidconf-ion_app-room:${TAGNAME}"
docker image tag vidconf-ion_app-room:latest howeli/vidconf-ion_app-room:${TAGNAME}
docker push howeli/vidconf-ion_app-room:${TAGNAME}
