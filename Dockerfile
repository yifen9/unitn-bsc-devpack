FROM ghcr.io/coder/code-server:4.91.1

USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y curl ca-certificates xz-utils \
    && rm -rf /var/lib/apt/lists/*

USER coder
WORKDIR /home/coder
RUN curl -L https://nixos.org/nix/install | sh -s -- --no-daemon --no-channel-add

SHELL ["/bin/bash", "-lc"]
RUN . "$HOME/.nix-profile/etc/profile.d/nix.sh" \
 && nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs \
 && nix-channel --update