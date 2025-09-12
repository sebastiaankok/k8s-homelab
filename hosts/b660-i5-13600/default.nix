{ config, lib, ...}:
{
  config = {
    hostConfig = {
      dataDir = "/data";
      user = "sebastiaan";
      interface = "enp3s0";
      sshPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOTvwNAE0ZUIgEZRlZqw48o5Sw8gZuCPaYUPUHEp/vtg sebastiaan@linux.com";
      services = {
        # system
        prometheus.enable = true;
      };
    };
  };

  # Host-specific configuration options
  imports = [
    ./hardware-configuration.nix
  ];

}
