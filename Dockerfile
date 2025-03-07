FROM phusion/baseimage:noble-1.0.0

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install rancher-cli
RUN mkdir /cli
WORKDIR /cli
RUN apt-get update && apt-get install -y wget apt-transport-https
RUN wget https://github.com/rancher/cli/releases/download/v2.10.1/rancher-linux-amd64-v2.10.1.tar.gz
RUN tar -xzf rancher-linux-amd64-v*.tar.gz
RUN rm -f rancher-linux-amd64-v*.tar.gz
RUN ln -s /cli/rancher-v2.10.1/rancher /usr/bin/rancher
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
RUN chmod 644 /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && apt-get install -y kubectl

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*