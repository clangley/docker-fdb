FROM ubuntu:20.04
RUN apt-get update && apt-get install -y python3 curl tini gettext-base
WORKDIR /root
RUN curl -k https://www.foundationdb.org/downloads/6.3.15/ubuntu/installers/foundationdb-clients_6.3.15-1_amd64.deb -o foundationdb-clients_6.3.15-1_amd64.deb
RUN curl -k https://www.foundationdb.org/downloads/6.3.15/ubuntu/installers/foundationdb-server_6.3.15-1_amd64.deb -o foundationdb-server_6.3.15-1_amd64.deb
RUN dpkg -i foundationdb-clients_6.3.15-1_amd64.deb foundationdb-server_6.3.15-1_amd64.deb
# https://forums.foundationdb.org/t/how-to-add-a-server-container-to-a-cluster/394/2
# https://forums.foundationdb.org/t/simple-dockerfile/280/5
RUN rm -r /var/lib/foundationdb/data/*
RUN rm -r /var/log/foundationdb/*

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x ./kubectl

ADD start.sh ./
ADD get_ip.py ./
ADD foundationdb.conf /etc/fdb/foundationdb.conf
CMD ["bash", "start.sh"]