{
  systemd.services.dailyBackup = {
    description = "Daily backup of /data to /storage/backups";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        /run/current-system/sw/bin/rsync -av --exclude='/library' --exclude='/frigate/frigate' /data/ /storage/backups/
      '';
    };
    wantedBy = [ "multi-user.target" ];
  };

  systemd.timers.dailyBackup = {
    description = "Run dailyBackup service every day at 06:00";
    timerConfig = {
      OnCalendar = "06:00";
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };
}
