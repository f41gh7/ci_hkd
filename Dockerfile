FROM alpine:latest

MAINTAINER devops@cybertonica.com



# Note: Latest version of kubectl may be found at:
# https://aur.archlinux.org/packages/kubectl-bin/
ENV KUBE_LATEST_VERSION="v1.8.3"
# Note: Latest version of helm may be found at:
# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION="v2.7.2"
ENV FILENAME="helm-${HELM_VERSION}-linux-amd64.tar.gz"
ENV DOCKER_VERSION=

RUN apk add --update ca-certificates \
    && apk add --update -t deps curl \
    && apk add bash \
    && apk add py-pip \
    && apk add docker \
    && apk add python-dev \
    && apk add libffi-dev \
    && apk add build-base gcc abuild binutils binutils-doc gcc-doc openssl openssl-dev\
    && pip install --upgrade pyopenssl \
    && pip install ansible \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L http://storage.googleapis.com/kubernetes-helm/${FILENAME} -o /tmp/${FILENAME} \
    && tar -zxvf /tmp/${FILENAME} -C /tmp \
    && mv /tmp/linux-amd64/helm /bin/helm \
    # Cleanup uncessary files
    && apk del --purge deps \
    && rm /var/cache/apk/* \
    && rm -rf /tmp/*

WORKDIR /config

CMD bash
