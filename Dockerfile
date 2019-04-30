FROM phusion/baseimage:0.11

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install rancher-cli
RUN mkdir /cli
WORKDIR /cli
RUN apt-get update && apt-get install -y wget apt-transport-https
RUN wget https://github.com/rancher/cli/releases/download/v2.2.0/rancher-linux-amd64-v2.2.0.tar.gz
RUN tar -xzf rancher-linux-amd64-v*.tar.gz
RUN rm -f rancher-linux-amd64-v*.tar.gz
RUN ln -s /cli/rancher-v2.2.0/rancher /usr/bin/rancher
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && apt-get install -y kubectl

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*