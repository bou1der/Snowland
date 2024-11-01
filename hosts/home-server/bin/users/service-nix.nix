{ ... }:

{

  users.users."service-nix" = {
    isNormalUser = true;
    home = "/home/service-nix";
    ignoreShellProgramCheck = true;
    extraGroups = [ "networkmanager" "docker" ];
  };
}
