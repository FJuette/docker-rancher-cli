FROM phusion/baseimage:0.11

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install rancher-cli
RUN mkdir /cli
WORKDIR /cli
RUN apt-get update && apt-get install -y wget
RUN wget https://github.com/rancher/cli/releases/download/v2.0.6/rancher-linux-amd64-v2.0.6.tar.gz
RUN tar -xzf rancher-linux-amd64-v2.0.6.tar.gz
RUN rm -f rancher-linux-amd64-v2.0.6.tar.gz
RUN ln -s /cli/rancher-v2.0.6/rancher /usr/bin/rancher

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*