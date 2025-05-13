{ pkgs, vars, ... }:

# let
#   key = secret: "${builtins.readFile /home/boulder/Snowland/.env/sshkeys/${secret}}";
# in
{
  programs.ssh = {
    enable = false;
  };

  # home.file."Snowland/.env/sshkeys/hosts".text = ''
  #   [192.168.0.5]:22001 ${key /home-server.ed }
  #
  #   [192.168.0.5]:22001 ${key /home-server.pub }
  #
  #   [46.150.174.46]:22001 ${key /home-server.ed }
  #
  #   90.156.253.98 ${key /kz_wg.pub}
  # '';
}

