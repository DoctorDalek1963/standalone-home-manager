# Standalone home-manager flake

This flake provides standalone home-manager configs for my accounts on non-NixOS machines. Bootstrapping Nix on these machines is often tricky since I rarely have root access.

The technique I used for DCS was to build [nixStatic](https://search.nixos.org/packages?channel=24.05&show=nixStatic&from=0&size=50&sort=relevance&type=packages&query=nixstatic) on a NixOS machine and SCP the binary to the target. Don't forget to recreate the symlinks. Then manually enable flakes in `~/.config/nix/nix.conf` and clone this repo. Then just `nix run . -- switch --flake .` to activate the config.
