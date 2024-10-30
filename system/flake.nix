{
  description = "My nixos system dotfile 🐢";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager }:
    let
      vars = import ./utils.nix;
      pkgs = import nixpkgs {
        system = vars.system;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations.${vars.username} = lib.nixosSystem {
        system = vars.system;
        nixpkgs.config.allowUnfree = true;
        modules = [ ./bin ];
      };
      hmConfig = {
        "${vars.username}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${vars.system};

          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              home = {
                username = vars.username;
                homeDirectory = "/home/${vars.username}";
                stateVersion = "24.05";
              };
            }
            ./lib
          ];
        };
      };
    };
}
