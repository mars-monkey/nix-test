{
  description = "Mars Monkey's Unified Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs:
  let
    inherit (nixpkgs.lib) nixosSystem;
  in {
    nixosConfigurations = {
      "jaguar" = nixosSystem {
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/jaguar
        ];
      };
      "here-nor-there" = nixosSystem {
        modules = [
          ./hosts/here-nor-there
        ];
      };
    };
  };
}
