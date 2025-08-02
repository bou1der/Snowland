{ pkgs, ... }:

{
  # services.pgadmin = {
  #   enable = true;
  #   initialEmail = "admin@test.ru";
  #   initialPasswordFile = ./password;
  # };

  # services.postgresql = {
  #   enable = true;
  #   settings.port = 5433;
  #   ensureDatabases = [ "mydatabase" ];
  #   authentication = pkgs.lib.mkOverride 10 ''
  #     #type database  DBuser  auth-method
  #     local all       all     trust
  #   '';
  # };
}
