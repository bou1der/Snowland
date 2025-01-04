{
  # description = "VPN server dotfile 🐢";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-lts.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { nixpkgs, nixpkgs-lts, sops-nix, ... }@inputs:
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
            soup-module = sops-nix.nixosModules.sops;
          };
        };

        nixos-nether = import ./image.nix;
      };
    };
}
