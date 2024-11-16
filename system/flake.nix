{
  description = "My nixos system dotfile 🐢";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      vars = import ./utils.nix;
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        system = vars.system;
      };
      special = {
        inherit inputs;
        inherit vars;
      };
    in
    {
      nixosConfigurations = {
        "${vars.username}" = lib.nixosSystem {
          system = vars.system;
          specialArgs = special;
          modules = [ ./bin ./hardware-configuration.nix ];
        };
      };
      hmConfig = {
        "${vars.username}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${vars.system};
          extraSpecialArgs = special;

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
