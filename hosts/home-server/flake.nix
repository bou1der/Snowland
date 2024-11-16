{
  # description = "Home server dotfile 🐢";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-lts.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, nixpkgs-lts, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-lts = import nixpkgs-lts {
        inherit system;
        config.allowUnfree = true;
      };

    in

    {
      colmena = {
        meta = {
          nixpkgs = pkgs;

          specialArgs = {
            inherit inputs;
          };
        };

        home-server = import ./image.nix;
      };
    };
}
