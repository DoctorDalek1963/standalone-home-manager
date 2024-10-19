{
  lib,
  config,
  inputs,
  ...
}: let
  inherit (lib) mkOption types;
  inherit (config.consts) valid-terminal-themes valid-shells;

  defaultTrue = mkOption {
    default = true;
    type = types.bool;
  };
  defaultFalse = mkOption {
    default = false;
    type = types.bool;
  };

  file-modules = [
    ./consts.nix

    ./modules/core.nix

    ./modules/terminal
    ./modules/maths
    ./modules/programming
  ];
  other-modules = [
    inputs.nix-index-database.hmModules.nix-index
  ];
in {
  imports = file-modules ++ other-modules;

  options.setup = {
    username = mkOption {
      type = types.nonEmptyStr;
    };
    homeDirectory = mkOption {
      type = types.nonEmptyStr;
    };
    homeManagerFlakePath = mkOption {
      type = types.nonEmptyStr;
    };

    # === Shell and terminal stuff

    terminal = {
      shells = {
        bash = defaultTrue;
      };
      defaultShell = mkOption {
        default = "bash";
        type = types.enum valid-shells;
      };
      shellAliases = mkOption {
        default = {};
        type = types.attrsOf types.nonEmptyStr;
      };

      emulators = {
        terminator = defaultFalse;
        wezterm = defaultTrue;
      };
      defaultEmulator = mkOption {
        default = "wezterm";
        type = types.enum ["terminator" "wezterm"];
      };

      multiplexer = mkOption {
        default = "zellij";
        type = types.enum ["none" "zellij"];
      };

      theme = mkOption {
        type = types.enum valid-terminal-themes;
        default = "catppuccin-macchiato";
      };

      tools = {
        # Need custom config
        aria2 = defaultTrue;
        bat = defaultTrue;
        btop = {
          enable = defaultTrue;
          gpuSupport = defaultTrue;
        };
        comma = defaultTrue;
        delta = defaultTrue;
        direnv = defaultTrue;
        fd = defaultTrue;
        fzf = defaultTrue;
        git = defaultTrue;
        git-all = defaultTrue;
        gh = defaultTrue;
        nvim = mkOption {
          type = types.enum ["stock" "tiny" "small" "medium" "full"];
          default = "medium";
        };
        lazygit = defaultTrue;
        ripgrep = defaultTrue;
        yazi = defaultTrue;

        # Just install the packages
        eza = defaultTrue;
        hyperfine = defaultTrue;
        just = defaultTrue;
        sad = defaultTrue;
        sd = defaultTrue;
        tldr = defaultTrue;
      };
    };

    # === Maths
    maths = {
      enable = defaultFalse;

      lintrans = defaultTrue;
      octave = defaultTrue;
      sage = defaultTrue;
      tikzit = defaultTrue;
      weylus = defaultTrue;
      zotero = defaultTrue;
    };

    # === Programming
    programming = {
      haskell = defaultFalse;
      julia = defaultFalse;
      python = defaultFalse;
      rust = defaultFalse;

      nix = defaultTrue;
    };
  };
}
