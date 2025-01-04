{ lib, ... }:

let
  key = secret: "${builtins.readFile secret}";
in

{
  programs.ssh.startAgent = true;

  services.openssh.enable = true;
  services.openssh.ports = [ 22001 ];

  users.users.root.openssh.authorizedKeys.keys = [ ''${key /home/boulder/.ssh/id_rsa.pub}'' ];
  # users.users."service-nix".openssh.authorizedKeys.keys = [ ''${key /home/boulder/.ssh/id_rsa.pub}'' ];

}
