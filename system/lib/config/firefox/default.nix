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

      extensions.packages = with inputs.fox-addons.packages.${vars.system}; [
        userchrome-toggle
        sidebery
        vimium
        bitwarden
        ublock-origin
      ];
      settings = {
        "permissions.default.shortcuts" = 1;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
      };
      search = {
        force = true;
        default = "google";
        order = [ "google" "ddg" ];
      };
    };
    languagePacks = [ "en-US" ];

  };
}
