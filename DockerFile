FROM nixos/nix:latest

RUN nix-env -iA nixpkgs.code-server \
                 nixpkgs.caddy \
                 nixpkgs.git \
                 nixpkgs.gcc \
                 nixpkgs.gnumake \
                 nixpkgs.cmake \
                 nixpkgs.python312 \
                 nixpkgs.nodejs_20 \
                 nixpkgs.yarn \
                 nixpkgs.zsh \
                 nixpkgs.bash

ARG USERNAME=dev
ARG UID=1000
RUN adduser -D -u ${UID} ${USERNAME}
USER ${USERNAME}
WORKDIR /home/${USERNAME}

ENV WORKSPACE=/workspace \
    CODE_SERVER_DATA=/home/${USERNAME}/.local/share/code-server \
    CODE_SERVER_CONFIG=/home/${USERNAME}/.config/code-server

RUN mkdir -p ${WORKSPACE} ${CODE_SERVER_DATA} ${CODE_SERVER_CONFIG}

USER root
COPY --chown=${USERNAME}:${USERNAME} scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY --chown=${USERNAME}:${USERNAME} caddy/Caddyfile /etc/caddy/Caddyfile
RUN chmod +x /usr/local/bin/entrypoint.sh
USER ${USERNAME}

RUN printf "bind-addr: 127.0.0.1:9000\nauth: none\n" > ${CODE_SERVER_CONFIG}/config.yaml

EXPOSE 8080

ENV FILEBROWSER_URL="https://drive.unitn.clarelab.moe" \
    IDE_DEFAULT_DIR="${WORKSPACE}"

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]