FROM lscr.io/linuxserver/code-server:latest

ENV YQ_VERSION=v4.22.1

# things to install
RUN                                                                                                                     \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main"    \
        | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list;                                                         \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg                                                          \
        | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -;                                                 \
    apt-get update -qq &&                                                                                               \
        apt-get install -qq -y                                                                                          \
            google-cloud-sdk                                                                                            \
            google-cloud-sdk-gke-gcloud-auth-plugin                                                                     \
            htop                                                                                                        \
            python                                                                                                      \
            kubectl                                                                                                     \
            mosh                                                                                                        \
            vim                                                                                                         \
            wget;                                                                                                       \
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash;                                    \
    wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64.tar.gz -O - |                   \
        tar xz && mv yq_linux_amd64 /usr/bin/yq

# add local files
COPY /root /

# ports and volumes
EXPOSE 8443
