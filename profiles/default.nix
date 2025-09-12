{ config, lib, pkgs, ... }:
{
  # Create a new user
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOTvwNAE0ZUIgEZRlZqw48o5Sw8gZuCPaYUPUHEp/vtg sebastiaan@linux.com"
    ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  powerManagement.powertop.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    neovim
    htop
    git
    lazygit
    bat
    powertop
    cpufrequtils
    pciutils
    sysz
    intel-gpu-tools
    socat
    smartmontools
    restic
    sops
    renovate
    bpftools
  ];

  environment.shellAliases = {
    "cat" = "bat -pp";
    "lg" = "lazygit";
    "up" = "nixos-rebuild switch --flake path:/root/nix-config --show-trace";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    configure = {
      customRC = ''
        filetype plugin indent on
        set expandtab
        set tabstop=2
        set softtabstop=2
        set shiftwidth=2
      '';
    };
  };

}

