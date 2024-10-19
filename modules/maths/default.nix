{
  pkgs,
  lib,
  config,
  system,
  inputs,
  ...
}: let
  cfg = config.setup.maths;
in {
  imports = [./octave.nix ./sage.nix];

  config = lib.mkIf cfg.enable {
    home.packages =
      lib.optional cfg.lintrans inputs.lintrans.packages."${system}".default
      ++ lib.optional cfg.tikzit pkgs.tikzit
      ++ lib.optional cfg.weylus pkgs.weylus
      ++ lib.optional cfg.zotero pkgs.zotero;
  };
}
