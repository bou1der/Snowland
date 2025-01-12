{ ... }:

let
  key = secret: "${builtins.readFile secret}";
in
{
  users.users.sunshine = {
      isNormalUser  = true;
      home  = "/home/sunshine";
      description  = "Sunshine Server";
      extraGroups  = [ "wheel" "networkmanager" "input" "video" "sound"];
      openssh.authorizedKeys.keys = [ ''${key /home/boulder/.ssh/id_rsa.pub}'' ];
  };
}
