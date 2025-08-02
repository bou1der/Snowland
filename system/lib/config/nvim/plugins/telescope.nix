
{
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader><leader>" = "find_files";
      "<leader>gg" = "live_grep";
      "<leader>gb" = "buffers";
      "<leader>gd" = "lsp_definitions";
    };
  };
}
