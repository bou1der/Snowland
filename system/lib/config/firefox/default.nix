{ pkgs, inputs, vars, ... }:
{
  home.file = {
    ".mozilla/firefox/${vars.username}/chrome" = {
      source = "${inputs.fox}/chrome";
    };

    ".mozilla/firefox/${vars.username}/user.js" = {
      source = "${inputs.fox}/user.js";
    };
  };

  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
    };
    profiles.${vars.username} = {

      extensions = with inputs.fox-addons.packages.${vars.system}; [
        userchrome-toggle
        sidebery
        vimium
        ublock-origin
        saka-key
      ];
      settings = {
        "permissions.default.shortcuts" = 1;
      };
      search = {
        force = true;
        default = "Google";
        order = [ "Google" "DuckDuckGo" ];
      };
    };
    languagePacks = [ "en-US" ];

  };
}
