{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    shellAliases = {
      k = "kubecolor";
      up = "sudo nixos-rebuild switch --flake path:/home/sebastiaan/projects/home-ops ; source ~/.zshrc";
      kx = "switch";
      synccluster = "export KUBECONFIG=$HOME/.kube/config; echo '' > $KUBECONFIG; tsh kube login --all --set-context-name {{.KubeName}}";
      ad = "kx k3s-home && kx ns argocd && argocd admin dashboard --core";
      ld = "eza -lD --icons=always" ;
      ll = "eza -l --group-directories-first --icons=always";
      ls = "eza -l --group-directories-first --icons=always";
      lS = "eza -lF --color=always --sort=size --icons=always | grep -v /";
      lt = "eza -l --sort=modified --icons=always";
      lg = "lazygit";
      tl = "timerecorder";
      cat = "bat -pp";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
        { name = "plugins/git"; tags = [ from:oh-my-zsh ]; }
        { name = "zsh-users/zsh-syntax-highlighting";}
      ];
    };

    plugins = [
      { name = "powerlevel10k-config"; src = ./p10k-config; file = "p10k.zsh"; }
    ];
  };
}
