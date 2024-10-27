{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # yandex-music= {
    #   url = "github:cucumber-sp/yandex-music-linux";
    # };

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        boulder = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
      hmConfig = {
        boulder = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home/home.nix
            {
              # imports = [
              #   yandex-music.homeManagerModules.default
              # ];
              home = {
                username = "boulder";
                homeDirectory = "/home/boulder";
                stateVersion = "24.05";
              };
              # programs.yandex-music = {
              #   enable = true;
              #   tray.enable = true;
              # };
            }
          ];
        };
      };
    };
}
