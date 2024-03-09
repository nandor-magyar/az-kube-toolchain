FROM python:3-alpine

# 
RUN apk add --no-cache curl bash-completion ncurses-terminfo-base ncurses-terminfo readline ncurses-libs bash nano ncurses git openssl vim coreutils

# kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl


# Helm
RUN cd /tmp && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod 700 ./get_helm.sh && ./get_helm.sh && rm ./get_helm.sh

# kubens / kubectx
RUN curl -L https://github.com/ahmetb/kubectx/archive/v0.4.0.tar.gz | tar xz \
    && cd ./kubectx-0.4.0 \
    && mv kubectx kubens utils.bash /usr/local/bin/ \
    && chmod +x /usr/local/bin/kubectx \
    && chmod +x /usr/local/bin/kubens \
    && cat completion/kubectx.bash >> ~/.bashrc \
    && cat completion/kubens.bash >> ~/.bashrc \
    && cd ../ \
    && rm -r ./kubectx-0.4.0


RUN apk add --virtual .az-deps gcc musl-dev python3-dev libffi-dev openssl-dev make
RUN pip install --upgrade pip
RUN pip install azure-cli

RUN apk del .az-deps

# Azure kubelogin
RUN curl -L https://github.com/Azure/kubelogin/releases/download/v0.0.13/kubelogin-linux-amd64.zip -o /tmp/kubelogin.zip && \
    unzip /tmp/kubelogin.zip -d /tmp/ && \
    mv /tmp/bin/linux_amd64/kubelogin /usr/local/bin/kubelogin && \
    chmod +X /usr/local/bin/kubelogin

# important alias
RUN echo "alias k=kubectl" >> ~/.bashrc

ENTRYPOINT ["bash"]