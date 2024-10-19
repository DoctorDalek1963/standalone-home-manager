{
  pkgs,
  config,
  ...
}: {
  home = {
    inherit (config.setup) username homeDirectory;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.11"; # Please read the comment before changing.

    packages = with pkgs; [
      # wl-clipboard
      xclip

      config.nix.package
    ];

    file = {
      ".inputrc".text = ''
        $include /etc/inputrc
        "\C-H": backward-kill-word
      '';
      ".XCompose".text = ''
        include "%L"
        <Multi_key> <b> <c> : "∵" # because
        <Multi_key> <t> <f> : "∴" # therefore
      '';
    };
  };

  nix = {
    package = pkgs.nix;

    settings = {
      # Keep the nix store optimised
      auto-optimise-store = true;

      # Enable flakes
      experimental-features = ["nix-command" "flakes"];

      # In a standalone config on a non-NixOS machine, we don't have Nix
      # running with root privileges
      sandbox = false;

      # Use lots of extra caches
      substituters = [
        "https://cache.nixos.org"
        "https://hydra.nixos.org"
        "https://nix-community.cachix.org"
        "https://doctordalek1963.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "doctordalek1963.cachix.org-1:ide2OUuSBdJY4mSTyIanZaafJhcHNA5fFh6P633b8EI="
      ];
    };

    # Garbage collect old packages every week
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  targets.genericLinux.enable = true;
}
