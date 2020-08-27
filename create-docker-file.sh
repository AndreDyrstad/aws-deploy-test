sudo docker container pull amazon/aws-iot-greengrass
docker run --rm --init -it --name aws-iot-greengrass --entrypoint /greengrass-entrypoint.sh -v $PWD/certs:/greengrass/certs -v $PWD/config:/greengrass/config -p 8883:8883 amazon/aws-iot-greengrass
