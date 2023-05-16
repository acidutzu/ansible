FROM debian:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    zip

# Add Docker's official GPG key and repository
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list

# Install Docker
RUN apt-get update && apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io

# Add system user to the Docker group
ARG linux_user_name=debi
RUN usermod -aG docker $linux_user_name

# Install kubectl
ARG KUBE_VER="v1.27.0"
RUN curl -LO "https://dl.k8s.io/release/$KUBE_VER/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install KIND
ARG KIND_VER="v0.18.0"
RUN curl -Lo /usr/local/bin/kind "https://kind.sigs.k8s.io/dl/$KIND_VER/kind-linux-amd64" \
    && chmod +x /usr/local/bin/kind

# Install HELM
RUN curl -fsSL -o /tmp/get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    && chmod +x /tmp/get_helm.sh \
    && /tmp/get_helm.sh

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

# Install ArgoCD CLI
RUN curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 \
    && chmod +x /usr/local/bin/argocd

# Install Minikube
RUN curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
    && install minikube-linux-amd64 /usr/local/bin/minikube

# Install kubecolor
RUN apt-get install -y kubecolor

# Configure kubectl autocomplete and add "k" alias
RUN echo "source <(kubectl completion bash)" >> ~/.bashrc \
    && echo "alias k=kubecolor" >> ~/.bashrc \
    && echo "complete -o default -F __start_kubectl kubecolor k" >> ~/.bashrc

# Install Terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update && apt-get install -y terraform
