{ pkgs, pkgs-unstable, lib, inputs, self, config, ... }:
with lib;

let
  cfg = {
    app = "k3s-home";
    vm = {
      hostname = "k3s-home";
      hypervisor = "qemu";
      mac = "12:22:de:ad:be:ea";
      cpu = 8;
      memory = 14 * 1024;
      network_mode = "private";
      interface = config.hostConfig.interface;
      user = config.hostConfig.user;
      ssh_public_key = config.hostConfig.sshPublicKey;
    };
  };

in
{
  microvm.vms."${cfg.vm.hostname}" = {
    autostart = true;

    config = {

      # Import VM configuration interface, disks
      microvm = import ./vm.nix { cfg = cfg; lib = lib; };

      # Import system and application configuration
      imports = [
        (import ./system.nix { inherit cfg; })
        (import ./k3s.nix { inherit cfg pkgs pkgs-unstable; })
      ];

    };
  };

  # Import host requirements
  imports = [
    ./k3s-secrets.nix
    ./storage.nix
  ];
}
