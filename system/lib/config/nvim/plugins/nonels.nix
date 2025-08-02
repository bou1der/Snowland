{pkgs, ...}:
{
  plugins.none-ls = {
    enable = true;
    package = pkgs.vimPlugins.none-ls-nvim;
    settings = {
      diagnostics_format = "[#{c}] #{m} (#{s})";
      on_attach = ''
        function(client, bufnr)
          -- Integrate lsp-format with none-ls
          require('lsp-format').on_attach(client, bufnr)
        end
      '';
      on_exit = ''
        function()
          print("Goodbye, cruel world!")
        end
      '';
      on_init = ''
        function(client, initialize_result)
          print("Hello, world!")
        end
      '';
      root_dir = ''
        function(fname)
          return fname:match("my-project") and "my-project-root"
        end
      '';
      root_dir_async = ''
        function(fname, cb)
          cb(fname:match("my-project") and "my-project-root")
        end
      '';
      should_attach = ''
        function(bufnr)
          return not vim.api.nvim_buf_get_name(bufnr):match("^git://")
        end
      '';
      temp_dir = "/tmp";
      update_in_insert = false;

    };
    #   = {
    #   enable = true;
    #
    # };
  };
}
