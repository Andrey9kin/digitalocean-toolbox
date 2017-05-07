FROM ubuntu:17.04

ENV K8S_VERSION="v1.6.2" 
ENV TF_VERSION="0.9.4"
ENV CFSSL_VERSION="1.2"
ENV DOCTL_VERSION="1.6.0"

RUN apt-get update && apt-get install --no-install-recommends -y ca-certificates dirmngr curl unzip && apt-get clean && rm -rf /var/lib/apt/lists

# Prepare to create user on startup of container
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# K8S
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${K8S_VERSION}/bin/linux/amd64/kubelet && mv kubelet /usr/local/bin
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${K8S_VERSION}/bin/linux/amd64/kubectl && mv kubectl /usr/local/bin

# Terraform
RUN curl -Lo tf.zip https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && unzip tf.zip && mv terraform /usr/local/bin/ && rm -f terraform

# CFSSL
RUN curl -Lo cfssl https://pkg.cfssl.org/R${CFSSL_VERSION}/cfssl-bundle_linux-amd64 && mv cfssl /usr/local/bin

# DOCTL
RUN curl -L https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz  | tar xz && mv doctl /usr/local/bin

# Make sure we can run all tools
RUN chmod -R ugo+x /usr/local/bin
