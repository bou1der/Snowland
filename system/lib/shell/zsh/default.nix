{ config, ... }:

{
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    useTheme = "atomic";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      upfl = "sudo nix-channel --update && nix flake update";
      nsw = "sudo nixos-rebuild switch --flake .#boulder --impure";
      hsw = "nix build .#hmConfig.boulder.activationPackage --impure && ./result/activate";
      rsw = "colmena apply --impure";
      gp = "git push";
      ga = "git add";
      gc = "git commit";
      gs = "git status";
      gr = "git restore";
      n = "nvim";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;

      plugins = [
        "aws"
        "docker"
        "encode64"
        "git"
        "git-extras"
        "man"
        "nmap"
        "sudo"
        "systemd"
        "tig"
        "tmux"
        "vi-mode"
        "yarn"
        "zsh-navigation-tools"
        "mix"
      ];
    };

  };
}
