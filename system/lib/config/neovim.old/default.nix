{ pkgs, lib, inputs, ... }:

let
  fromGitHub = ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
    };
  };

  read = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  depends = req: "\nlua << EOF \n${req}\nEOF\n";
  text = file: "\n${builtins.readFile file}\n";
in

{
  programs.neovim = {
    enable = false;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;


    extraLuaConfig = ''
      ${text ./config/keymaps.lua}
      ${text ./config/options.lua}
      ${text ./config/autocmd.lua}
      ${text ./config/importconverter.lua}
      ${text ./config/yank_highlight.lua}
    '';

    plugins = with pkgs.vimPlugins; [

       {
         plugin = LazyVim;
         config = ''
             ${read ./config/lazyConfig.lua}
      
             ${depends ''
               require("lazy").setup({
                 {
                   ${text ./config/plugins/colorschemes.lua}
                   ${text ./config/plugins/mini.lua}
                   ${text ./config/plugins/treesitter.lua}
                   ${text ./config/plugins/ui.lua}
                   ${text ./config/plugins/nvim_tree.lua}
                   ${text ./config/plugins/nonels.lua}
                   ${text ./config/plugins/formatting.lua}
                   ${text ./config/plugins/cmp.lua}
                   ${text ./config/plugins/cmake-tools.lua}
                   ${text ./config/plugins/runner.lua}
                   ${text ./config/plugins/markdown.lua}
                   ${text ./config/plugins/pdf.lua}
                 },
                 {
                   ${text ./config/plugins/lsp/mason.lua}
                   ${text ./config/plugins/lsp/lspconfig.lua}
                 }
               })
               ''
           }
         '';
       }

	    #   plugin = nvim-lspconfig;
	    #   type = "lua";
	    #   config = "require('lspconfig').tailwindcss.setup{}";
	    # }

    ];
    extraPackages = with pkgs; [
      go
      gopls
    ];
  }; }
