{
  description = "mkk nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
    }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .
      darwinConfigurations."Sokrates" = nix-darwin.lib.darwinSystem {
        modules = [
          ./configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
}