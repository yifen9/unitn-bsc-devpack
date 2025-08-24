FROM ghcr.io/coder/code-server:latest

USER coder
WORKDIR /home/coder
RUN sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-channel-add
SHELL ["/bin/bash", "-lc"]
RUN . "$HOME/.nix-profile/etc/profile.d/nix.sh" \
 && nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs \
 && nix-channel --update \
 && mkdir -p ~/.config/nix && printf "experimental-features = nix-command flakes\n" > ~/.config/nix/nix.conf

COPY --chown=coder:coder nix /home/coder/nix
RUN . "$HOME/.nix-profile/etc/profile.d/nix.sh" \
 && nix profile install /home/coder/nix#devpack

ENV WORKSPACE=/workspace
RUN mkdir -p "$WORKSPACE"
ENTRYPOINT ["bash","-lc","code-server --bind-addr 0.0.0.0:8080 --auth=none /workspace"]
EXPOSE 8080