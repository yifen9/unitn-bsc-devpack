FROM ghcr.io/coder/code-server:4.91.1

USER root
RUN apt-get update \
 && apt-get install -y curl ca-certificates xz-utils bash \
 && rm -rf /var/lib/apt/lists/*

USER coder
WORKDIR /home/coder
RUN curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
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
RUN mkdir -p /home/coder/.config/code-server \
 && printf "bind-addr: 0.0.0.0:8080\nauth: none\n" > /home/coder/.config/code-server/config.yaml \
 && chown -R coder:coder /home/coder/.config

USER coder
ENTRYPOINT ["code-server","/workspace"]
EXPOSE 8080
