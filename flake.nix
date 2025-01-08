{
  description = "momiji's nixvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixvim, flake-utils, nixpkgs, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        nixvim' = nixvim.legacyPackages.${system};
        nvim = nixvim'.makeNixvimWithModule {
          inherit pkgs;
          module = ./config;
          extraSpecialArgs = { inherit inputs system; };
        };
      in {
        packages.default = nvim;

        devShells = {
          default = with pkgs; mkShell { buildInputs = [ nvim ]; };
        };
      });
}
