{
  programs.nixvim = {
    plugins = {
      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>gd";
        action = ":Gitsigns diffthis";
        options = {
          noremap = true;
          buffer = true;
        };
      }
    ];
  };
}
