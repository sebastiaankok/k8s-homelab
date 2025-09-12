{
  programs.atuin = {
    enable = true;
    flags = [
      "--disable-up-arrow"
    ];
    settings = {
      sync_frequency = "15m";
    };
  };
}
