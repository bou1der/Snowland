{
  imports = [
    ./hardware-configuration.nix
    ./bin
    ./services
    ../soups.nix
  ];

  # shared-box = {
  #   deployment.keys.".keys.secret" = {
  #     destDir = "/run/secrets.d/";
  #     uploadAt = "pre-activation"; # Default: pre-activation, Alternative: post-activation
  #   };
  # };
}
