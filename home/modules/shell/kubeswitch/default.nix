{ config, pkgs, ... }:
let
  ## Bug where switcher script is not available.
  newKubeswitch = pkgs.kubeswitch.overrideAttrs (oldAttrs: rec {
    postInstall = ''
      mv $out/bin/main $out/bin/switcher
    '';
  });
in

{
  home.packages = with pkgs; [
    newKubeswitch
  ];

  home.file = {
    ".kube/switch-config.yaml".source = ./switch-config.yaml;
  };

}
