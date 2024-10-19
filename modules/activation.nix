{
  lib,
  config,
  ...
}: {
  home.activation =
    if config.setup.secrets.enable
    then {
      restartSopsNix = lib.hm.dag.entryAfter ["writeBoundary"] ''
        $DRY_RUN_CMD /run/current-system/sw/bin/systemctl restart --user sops-nix
      '';
    }
    else {};
}
