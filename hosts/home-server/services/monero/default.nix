
{ pkgs, ... }:

{
  services.monero = {
    enable = false;
    mining.enable = false;
    
  };
}
