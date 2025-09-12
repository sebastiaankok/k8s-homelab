{
  programs.nixvim.plugins = {
   lualine = {
      enable = true;
      settings = {
        extensions = ["neo-tree"];
        options = {
          globalstatus = true;
        };
      };
    };
  };
}
