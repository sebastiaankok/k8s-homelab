{ lib, config, pkgs, ... }:
with lib;
{
  # build a restic restore set for both local and remote
  sops.secrets."rclone-config" = {
    sopsFile = ./secrets.sops.yaml;
  };

  sops.secrets."restic-repo-password" = {
    sopsFile = ./secrets.sops.yaml;
  };

  sops.secrets."scaleways3-config" = {
    sopsFile = ./secrets.sops.yaml;
  };

  sops.secrets."b2s3-config" = {
    sopsFile = ./secrets.sops.yaml;
  };

  lib.hostConfig.mkRestic = options: (
    let
      excludePath = if builtins.hasAttr "excludePath" options then options.excludePath else [ ];
      excludeGlacier = if builtins.hasAttr "excludeGlacier" options then options.excludeGlacier else [ ];
      timerConfig = {
        OnCalendar = "02:15";
        Persistent = true;
        RandomizedDelaySec = "3h";
      };
      initialize = true;
      backupPrepareCommand = ''
        # remove stale locks - this avoids some occasional annoyance
        #
        ${pkgs.restic}/bin/restic unlock --remove-all || true
      '';
    in
    {

      # local backup
      "local-${options.app}" = {
        inherit timerConfig initialize backupPrepareCommand;
        paths = options.paths;
        passwordFile = config.sops.secrets."restic-repo-password".path;
        repository = "/storage/backups/${options.app}";
        exclude = excludePath;
        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 1"
          "--keep-monthly 1"
          "--keep-yearly 1"
        ];
      };

      # b2 backup
      "b2-${options.app}" = {
        inherit timerConfig initialize backupPrepareCommand;
        paths = options.paths;
        environmentFile = config.sops.secrets."b2s3-config".path;
        passwordFile = config.sops.secrets."restic-repo-password".path;
        repository = "s3:s3.eu-central-003.backblazeb2.com/nixos-homelab/backups/${options.app}";
        exclude = excludePath;
        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 1"
          "--keep-monthly 1"
          "--keep-yearly 1"
        ];
      };

      # scaleway glacier backup
      "scaleway-${options.app}" = {
        inherit timerConfig initialize backupPrepareCommand;
        paths = options.paths;
        environmentFile = config.sops.secrets."scaleways3-config".path;
        extraOptions = [ "s3.storage-class=GLACIER" ];
        passwordFile = config.sops.secrets."restic-repo-password".path;
        repository = "s3:s3.nl-ams.scw.cloud/nixos-homelab/backups/${options.app}";
        exclude = excludePath ++ excludeGlacier;
        pruneOpts = [];
      };
    }
  );

}
