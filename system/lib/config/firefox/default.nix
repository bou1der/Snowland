{ config, pkgs, inputs, vars, lib, ... }:
{
  # home.file.".mozilla/firefox/${vars.username}/chrome" = {
  #   source = config.lib. ./config/chrome;
  #   recursive = true;
  # };

  home.activation.firefoxActivation = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ln -s $VERBOSE_ARG --force ${builtins.toPath ./config/chrome } $HOME/.mozilla/firefox/${vars.username}/chrome
  '';

  home.file."Downloads/temp/text".text = ''
    $VERBOSE_ARG

    ${builtins.toPath ./config/chrome }

    $HOME/.mozilla/firefox/${vars.username}/chrome
  '';

  programs.firefox = {
    enable = true;
    profiles.${vars.username} = { };
  };

}
