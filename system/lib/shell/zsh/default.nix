{
  config,
  vars,
  pkgs,
  ...
}:

let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
  color = pkgs.lib.importJSON "/home/${vars.username}/.cache/wal/colors.json";
in
{

  imports = [
    ./theme.nix
  ];

  home.packages = with pkgs; [
    zoxide
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      export EDITOR=nvim
      export GEMINI_API_KEY=${env "ai/gemini"}
      eval "$(zoxide init zsh)"
    '';

    # export PATH=" /home/boulder/.bun/bin =$PATH"

    shellAliases = {
      upfl = "sudo nix-channel --update && nix flake update";
      nsw = "sudo nixos-rebuild switch --flake .#${vars.username} --impure";
      hsw = "nix build .#hmConfig.${vars.username}.activationPackage --impure && ./result/activate";
      rsw = "colmena apply --impure";
      shell = "nix develop";
      # dev = "sudo tailscale up --login-server https =//tail.${env "vpn/domain"} --authkey $(node ${../../../../hosts/cluster/config/gen-token.js} ${env "vpn/apikey"} https://tail.${env "vpn/domain"} ${vars.username})";
      # down = "sudo tailscale down";
      doclean = "docker stop $(docker ps -aq) && docker rm $(docker ps -aq) && docker volume rm $(docker volume ls -q)";
      dost = "docker stop $(docker ps -aq)";
      cd = "z";
      gp = "git push";
      ga = "git add";
      gc = "git commit";
      gs = "git status";
      gr = "git restore";
      n = "nvim";
      k = "kubectl";
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

      # ZSH_THEME_GIT_PROMPT_PREFIX="%{''$fg[red]%}‹"
      # ZSH_THEME_GIT_PROMPT_SUFFIX="›%{''$reset_color%}"

      # extraConfig = ''
      #   zstyle  =omz:plugins:ssh-agent identities id_rsa id_rsa2 id_github
      #
      #   # -*- sh -*- vim =set ft=sh ai et sw=4 sts=4:
      #   autoload -U color && colors
      #   zstyle ' =vcs_info:git:*' formats '%b '
      #
      #   PROMPT='%b%{$fg[green]%}%n@%m =%{''$fg_bold[blue]%}%d $(git_prompt_info)%{''$reset_color%}%(!.#.$) '
      #
      # '';

    };

  };
}
