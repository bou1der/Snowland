{ lib, ... }:


let
  vars = import ./utils.nix;
in
with lib;
{
  options.env-module = {
    color-schema = mkOption {
      type = types.anything;
      default = null;
      description = "Gen pywall colorschema";
    };
  };

  env-module = importJSON /home/${vars.username}/.cache/wal/colors.json;
}
