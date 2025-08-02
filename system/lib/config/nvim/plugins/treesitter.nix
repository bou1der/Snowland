{pkgs, ...}:

{
  plugins.treesitter = {
    enable = true;
    autoLoad = true;

    settings = {
      auto_install = true;
      ensure_installed = [
        "git_config"
        "git_rebase"
        "gitattributes"
        "gitcommit"
        "gitignore"
      ];
      indent.enable = true;
      highlight.enable = true;
    };

    # folding = false;
    nixvimInjections = true;
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
  };
}
