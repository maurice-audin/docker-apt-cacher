FROM debian:buster

RUN apt-get update && apt-get install -y --no-install-recommends \
        apt-cacher-ng\
        && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["apt-cacher-ng", "ForeGround=1", "PassThroughPattern=.*:443"]
