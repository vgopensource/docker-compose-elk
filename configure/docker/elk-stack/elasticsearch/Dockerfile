FROM elasticsearch:latest

RUN apt-get -y update && apt-get install -y vim

CMD ["-E", "network.host=0.0.0.0", "-E", "discovery.zen.minimum_master_nodes=1"]

RUN echo "* - nofile 65535" >> /etc/security/limits.conf && \
    echo "* - memlock unlimited" >> /etc/security/limits.conf && \
    echo vm.max_map_count=262144 > /etc/sysctl.d/max_map_count.conf && \
    echo vm.swappiness=0 > /etc/sysctl.d/swappiness.conf

