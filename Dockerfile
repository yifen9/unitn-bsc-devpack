FROM ghcr.io/coder/code-server:4.91.1

USER root
RUN apt-get update \
 && apt-get install -y caddy curl ca-certificates xz-utils bash \
 && rm -rf /var/lib/apt/lists/*

USER coder
WORKDIR /home/coder

RUN curl -fsSL https://nixos.org/nix/install | sh -s -- --no-daemon --yes
SHELL ["/bin/bash", "-lc"]
RUN . "$HOME/.nix-profile/etc/profile.d/nix.sh" \
 && mkdir -p ~/.config/nix \
 && echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

COPY --chown=coder:coder nix /home/coder/nix
RUN . "$HOME/.nix-profile/etc/profile.d/nix.sh" \
 && nix profile install /home/coder/nix#devpack

USER root
ENV WORKSPACE=/workspace
RUN mkdir -p "$WORKSPACE" && chown coder:coder "$WORKSPACE"

COPY --chown=coder:coder nav /home/coder/nav
COPY --chown=coder:coder caddy/Caddyfile /etc/caddy/Caddyfile

USER coder
RUN mkdir -p ~/.config/code-server \
 && printf "bind-addr: 127.0.0.1:9000\nauth: none\n" > ~/.config/code-server/config.yaml

ENTRYPOINT [
    "/bin/bash",
    "-lc",
    "nohup code-server /workspace >/tmp/code.log 2>&1 & exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile"]
EXPOSE 8080