{ pkgs, ... }:

{
  services.kubernetes = {
    roles = ["master" "node"];
    package = pkgs.kubernetes;
    masterAddress = "localhost";
  };
}
