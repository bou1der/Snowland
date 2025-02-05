{
  description = "My nixos system dotfile 🐢";

  inputs = {

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    fox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fox = {
      type = "git";
      url = "https://github.com/Naezr/ShyFox.git";
      submodules = true;
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }@inputs:
    let
      vars = import ./utils.nix;
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        system = vars.system;
      };
    in
    {
      nixosConfigurations = {
        "${vars.username}" = lib.nixosSystem {
          system = vars.system;

          specialArgs = {
            inherit inputs;
            inherit vars;
            soup-module = sops-nix.nixosModules.sops;
          };

          modules = [
            ./bin
            ./hardware-configuration.nix
            ../soups.nix
          ];
        };
      };
      hmConfig = {
        "${vars.username}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${vars.system};
          extraSpecialArgs = {
            inherit inputs;
            inherit vars;
            soup-module = sops-nix.homeManagerModules.sops;
          };
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
            ../soups.nix
          ];
        };
      };
    };
}
