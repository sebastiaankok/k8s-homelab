{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      keymaps = {
        # Find files using Telescope command-line sugar.
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>b" = "buffers";
        "<leader>fh" = "help_tags";
        "<leader>fd" = "diagnostics";
      };

      extensions = {
        file-browser = { enable = true; };
        fzf-native = { enable = true; };
      };
      settings = {
        defaults = {
          prompt_prefix = "";
          entry_prefix = "  ";
          layout_config = {
            horizontal = {
              prompt_position = "top";
              preview_width = 0.55;
              results_width = 0.8;
            };
            vertical = { mirror = false; };
            width = 0.7;
            height = 0.6;
            preview_cutoff = 80;

          };
          border = true;
          sorting_strategy = "ascending";
          file_ignore_patterns = [
            "^.git/"
            "^.mypy_cache/"
            "^__pycache__/"
            "^output/"
            "^data/"
            "%.ipynb"
            "node_modules"
            "^.pytest_cache/"
            "^.direnv/"
          ];
          set_env = { COLORTERM = "truecolor"; };
          mappings = {
            n = { "q" = { __raw = "require('telescope.actions').close"; }; };
          };
        };
      };

      extensions.ui-select.enable = true;

    };
  };
}
