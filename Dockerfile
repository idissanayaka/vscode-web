FROM lscr.io/linuxserver/code-server:latest

COPY --chown=1000:1000 extensions install-extensions.sh /

RUN chmod +x /install-extensions.sh && \
    /install-extensions.sh && \
    rm -f /install-extensions.sh /extensions

RUN curl -sSL https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz -o /tmp/nvim.tar.gz && \
    tar -xzf /tmp/nvim.tar.gz -C /usr/local/ && \
    ln -s /usr/local/nvim-linux64/bin/nvim /usr/local/bin/nvim && \
    ln -s /usr/local/nvim-linux64/bin/nvim /usr/bin/nvim && \
    rm -f /tmp/nvim.tar.gz
