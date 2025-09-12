{
  programs.nixvim = {
    plugins = {
      copilot-lua = {
        enable = true;
        settings = {
          filetypes = { yaml = true; };
          suggestion.enabled = true;
          suggestion.autoTrigger = true;
          suggestion.keymap = {
            accept = "<C-a>";
            acceptLine = "<C-s>";
            acceptWord = "<C-d>";
            next = "<C-k>";
            prev = "<C-l>";
          };
        };
      };
    };
  };
}
