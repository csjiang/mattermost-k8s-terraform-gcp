# dev environment
FROM centos:8

MAINTAINER CS Jiang <csjiang@protonmail.com>

ARG USERNAME=mattermost-dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

COPY deps/google-cloud-sdk.repo /etc/yum.repos.d/google-cloud-sdk.repo

# install dependencies
RUN dnf clean all && rm -r /var/cache/dnf  && dnf upgrade -y && dnf update -y && \
dnf install -y wget which sudo glibc-locale-source \
man man-db man-pages git unzip google-cloud-sdk jq

# set up non-root user with sudo access
RUN groupadd --gid $USER_GID $USERNAME && \
	useradd --create-home --shell /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

# fix locale 
RUN localedef --no-archive -i en_US -f UTF-8 en_US.UTF-8 && \
	export LANG=en_US.UTF-8

# install kubectl v1.21.0-beta.0
WORKDIR /opt
RUN set -ex; \
	wget https://dl.k8s.io/v1.21.0-beta.0/kubernetes-client-linux-amd64.tar.gz && \
	echo '0cbb4123ba730bb980721ca7f05bc68c97f4194133c9f1905e9beaec6e3e5405  /opt/kubernetes-client-linux-amd64.tar.gz' | sha256sum --check && \
	tar xzvf kubernetes-client-linux-amd64.tar.gz && \
	mv kubernetes/client/bin/kubectl /usr/local/bin/kubectl && \
	chmod 755 /usr/local/bin/kubectl && \
	rm -f kubernetes-client-linux-amd64.tar.gz && \
	rm -rf kubernetes

# install Helm v3.5.2
WORKDIR /opt
RUN set -ex; \
	wget https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz && \
	echo '01b317c506f8b6ad60b11b1dc3f093276bb703281cb1ae01132752253ec706a2  /opt/helm-v3.5.2-linux-amd64.tar.gz' | sha256sum --check && \
	tar xzvf helm-v3.5.2-linux-amd64.tar.gz && \
	mv linux-amd64/helm /usr/local/bin/helm && \
	chmod 755 /usr/local/bin/helm && \
	rm -f helm-v3.5.2-linux-amd64.tar.gz && \
	rm -rf linux-amd64

# helm diff plugin
RUN helm plugin install https://github.com/databus23/helm-diff --version 3.1.3

# install terraform v0.14.7
WORKDIR /opt
RUN set -ex; \
wget https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip && \
echo '6b66e1faf0ad4ece28c42a1877e95bbb1355396231d161d78b8ca8a99accc2d7  /opt/terraform_0.14.7_linux_amd64.zip' | sha256sum --check && \
unzip terraform_0.14.7_linux_amd64.zip && \
mv terraform /usr/local/bin/ && \
rm -rf terraform_0.14.7_linux_amd64.zip

RUN chown -R $USER_UID:$USER_GID /usr/local/bin && chmod -R 755 /usr/local/bin

USER $USERNAME

WORKDIR /home/$USERNAME

CMD /bin/bash

