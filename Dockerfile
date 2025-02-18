FROM    ubuntu:18.04

# Prepare OS
COPY    setup-os.sh /root
RUN     /root/setup-os.sh

# Copy package from build directory
ARG     implyversion
ADD     imply-$implyversion.tar.gz /opt/
RUN     mkdir -p /mnt/imply/var && ln -snf /mnt/imply/var /opt/imply-${implyversion}/var
RUN     ln -snf /opt/imply-${implyversion} /opt/imply

# Copy our config
COPY    config.yaml /opt/imply-${implyversion}/conf-quickstart/pivot/

# Crack imply
COPY    .imply-first-run /opt/imply-${implyversion}/var/pivot/

# Imply data
VOLUME /mnt/imply/var

EXPOSE  1527 2181 8081 8082 8083 8090 8091 8100 8101 8102 8103 8104 8105 8106 8107 8108 8109 8110 8200 9095

WORKDIR /opt/imply-$implyversion

CMD     ["bin/supervise", "-c", "conf/supervise/quickstart.conf"]
