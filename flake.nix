{
  description = "DoctorDalek1963's standalone home-manager flake for non-NixOS machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lintrans.url = "github:DoctorDalek1963/lintrans";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config.url = "github:DoctorDalek1963/nixvim-config";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};

    extraSpecialArgs = {
      inherit system inputs;
    };
  in {
    packages.${system}.default = home-manager.defaultPackage.${system};

    homeConfigurations = {
      "u5503449" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [
          ./setup.nix
          {
            setup = rec {
              username = "u5503449";
              homeDirectory = "/dcs/24/u5503449";
              homeManagerFlakePath = "${homeDirectory}/repos/standalone-home-manager";

              terminal.tools.nvim = "small";
              programming.python = true;

              maths = {
                enable = true;
                sage = false;
              };
            };

            nix.settings.ssl-cert-file = "/etc/ssl/cert.pem";
          }
        ];
      };
    };
  };
}
