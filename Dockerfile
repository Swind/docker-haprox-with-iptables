FROM haproxytech/haproxy-ubuntu:3.0

# install iptables and network tools
RUN apt-get update && apt-get install -y \
  curl wget vim iptables-persistent && \
  rm -rf /var/lib/apt/lists/*

VOLUME /data

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["haproxy", "-f", "/data/haproxy/haproxy.cfg"]
