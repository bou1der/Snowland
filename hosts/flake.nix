{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-lts.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { nixpkgs, nixpkgs-lts, sops-nix, ... }@inputs:
    let
      vars = import ./vars.nix;
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
          nixpkgs = pkgs-lts;

          specialArgs = {
            inherit inputs;
            inherit vars;
            soup-module = sops-nix.nixosModules.sops;
          };
        };

        home-server = import ./home-server/image.nix;
        nix-nether = import ./nix-nether/image.nix;
      };
    };
}
