{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      nixvimInjections = true;

      folding = true;
      settings = {
        indent.enable = true;
        highlight = { enable = true; };
      };
    };

    treesitter-refactor = {
      enable = true;
      highlightDefinitions.enable = true;
    };

    hmts.enable = true;
  };
}
