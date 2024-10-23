FROM lscr.io/linuxserver/code-server:latest

COPY --chown=1000:1000 extensions install-extensions.sh /

RUN chmod +x /install-extensions.sh && \
    /install-extensions.sh && \
    rm -f /install-extensions.sh /extensions

# Install neovim
RUN curl -sSL https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz -o /tmp/nvim.tar.gz && \
    tar -xzf /tmp/nvim.tar.gz -C /usr/local/ && \
    ln -s /usr/local/nvim-linux64/bin/nvim /usr/local/bin/nvim && \
    ln -s /usr/local/nvim-linux64/bin/nvim /usr/bin/nvim && \
    rm -f /tmp/nvim.tar.gz

# Install kubectl, kubectx, kubens
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm -f kubectl
RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx && \
    ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx && \
    ln -s /opt/kubectx/kubens /usr/local/bin/kubens