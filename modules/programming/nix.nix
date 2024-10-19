{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.setup.programming.nix {
    home.packages = with pkgs; [
      alejandra
      deadnix
      nh
      nix-output-monitor
      nix-tree
      nvd
      statix
    ];

    setup.terminal.shellAliases = rec {
      n = "nix";
      nhhm = "FLAKE=${config.setup.homeManagerFlakePath} ${pkgs.nh}/bin/nh home";
      nhos = nhhm; # Muscle memory
    };
  };
}
