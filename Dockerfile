FROM ghcr.io/linuxserver/code-server:latest

RUN                                                                                                                     \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main"    \
        > /etc/apt/sources.list.d/google-cloud-sdk.list;                                                                \
                                                                                                                        \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg                                                       \
        > /usr/share/keyrings/cloud.google.gpg;                                                                         \
                                                                                                                        \
    apt-get update -qq &&                                                                                               \
        apt-get upgrade -qq -y &&                                                                                       \
        apt-get install -qq -y                                                                                          \
            google-cloud-sdk                                                                                            \
            google-cloud-sdk-gke-gcloud-auth-plugin                                                                     \
            htop                                                                                                        \
            python3                                                                                                     \
            kubectl                                                                                                     \
            mosh                                                                                                        \
            vim                                                                                                         \
            wget                                                                                                        \
            build-essential;                                                                                            \
                                                                                                                        \
    curl -s https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3                                         \
        | bash;                                                                                                         \
                                                                                                                        \
    wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq &&                      \
        chmod +x /usr/bin/yq;                                                                                           \
                                                                                                                        \
    wget 'https://github.com/cert-manager/cert-manager/releases/latest/download/cmctl-linux-amd64.tar.gz' -O - |        \
        tar -zxf - -C /usr/bin cmctl;                                                                                   \
                                                                                                                        \
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";   \
                                                                                                                        \
    echo 'abc ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/00-abc-nopasswd;                                                 \
    chmod 0440 /etc/sudoers.d/00-abc-nopasswd;                                                                          \
    mkdir /config;                                                                                                      \
    chown abc:abc /config;

# ports and volumes
EXPOSE 8443
