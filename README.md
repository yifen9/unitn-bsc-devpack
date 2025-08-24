# A WebUI-based DevPack for UniTn BSc students

It integrates with C++, PolyML and so on. I will add more supports soon or later, aiming for 100% coverage of our study plan. 

Notice:
- If you know how to use Docker, image pulled from ghcr.io/yifen9/unitn-bsc-devpack:latest, or simply check the compose.yaml
- If you don't know how to use Docker, but you use Linux, check the release page, both of the Linux-based release will construct the whole package from scratch via Nix
- If you don't know how to use Docker and you don't use Linux, please install Docker Desktop first and switch to Linux containers (by right clicking the tray), and then you can use the Windows-based release
- If you use Mac, check the darwin version of release (untested)

Have done:
- A nice WebUI-based VSCode (code-server) via Docker image (check Dockerfile)
- Nix-based package management (check /nix/flake.nix and /nix/packages.nix)
- A filebrowser-based remote drive running on my VPS with Caddy (check https://clarelab.moe)
- A nice iframe on the main page with nav bar as header and footer

TODO:
- SQL integration (for databases course in the 3rd seme)
- Shared drive via O-Auth instead of dummy auth
- Try to find a way to bypass Docker on Windows and on Mac (mission impossible)

Concerns:
- None as for now

Contacts:
- Find it on my profile