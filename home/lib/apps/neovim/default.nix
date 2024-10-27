{ config, pkgs, lib, ... }:

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

  file = file: "${builtins.readFile file}";
in

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${file ./config/keymaps.lua}

      ${file ./config/options.lua}
    '';

    plugins = with pkgs.vimPlugins; [
      {
        plugin = LazyVim;
        config = ''
            ${read ./config/lazyConfig.lua}

            ${depends ''
              require("lazy").setup({
                {
                  ${file ./config/plugins/colorschemes.lua}
                  ${file ./config/plugins/mini.lua}
                  ${file ./config/plugins/treesitter.lua}
                  ${file ./config/plugins/supermaven.lua}
                  ${file ./config/plugins/ui.lua}
                  ${file ./config/plugins/nvim_tree.lua}
                  ${file ./config/plugins/nonels.lua}
                  ${file ./config/plugins/formatting.lua}
                  ${file ./config/plugins/cmp.lua}
                  ${file ./config/plugins/cmake-tools.lua}
                  ${file ./config/plugins/runner.lua}
                  ${file ./config/plugins/markdown.lua}

                },
                {
                  ${file ./config/plugins/lsp/mason.lua}
                  ${file ./config/plugins/lsp/lspconfig.lua}
                }
              })
              ''
          }
        '';
      }

      # lazygit-nvim
      rocks-nvim
    ];
  };
}
