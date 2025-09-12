{ config, lib, ... }:
with lib;
{
  options.hostConfig.dataDir = mkOption {
    type = types.str;
    description = "Data directory for applications";
    default = "/data";
  };

  options.hostConfig.nfsDir = mkOption {
    type = types.str;
    description = "folder where NFS is mounted";
    default = "/nfs";
  };
  options.hostConfig.domainName = mkOption {
    type = types.str;
    description = "Domain used for services";
    default = "";
  };
  options.hostConfig.role = mkOption {
    type = types.str;
    description = "Device role";
    default = "Server";
  };
  options.hostConfig.interface = mkOption {
    type = types.str;
    description = "Network interface";
    default = "eth1";
  };
  options.hostConfig.user = mkOption {
    type = types.str;
    description = "System user that gets added";
    default = "bob";
  };
  options.hostConfig.sshPublicKey = mkOption {
    type = types.str;
    description = "System public key";
    default = "";
  };


  imports = [
    ./services
    ./lib.nix
  ];
}
