FROM debian:buster

# Use local apt cache
RUN apt-get update && apt-get install -y netcat \
        && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
        && echo '#! /bin/bash\nif nc -w1 -z 192.168.42.23 3142; then echo "http://192.168.42.23:3142"; else echo "DIRECT"; fi' > /usr/local/bin/apt-proxy-checker \
        && chmod +x /usr/local/bin/apt-proxy-checker \
        && echo 'Acquire::http::ProxyAutoDetect "/usr/local/bin/apt-proxy-checker";' > /etc/apt/apt.conf.d/proxy

# Install apt-cacher-ng
RUN apt-get update && apt-get install -y --no-install-recommends \
        apt-cacher-ng\
        && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Run foreground for docker purpose, do not cache https repositories
ENTRYPOINT ["apt-cacher-ng", "ForeGround=1", "PassThroughPattern=.*:443"]
