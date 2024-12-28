{
  description = "momiji's nixvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
  {
    nixvim,
    flake-parts,
    ...
  }@inputs:
  flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    perSystem =
    {
      system,
      pkgs,
      self',
      ...
    }:
    let
      nixvim' = nixvim.legacyPackages.${system};
      nvim = nixvim'.makeNixvimWithModule {
        inherit pkgs;
        module = ./config;
        extraSpecialArgs = {
          inherit inputs system;
        };
      };
    in
    {
      packages.default = nvim;

      devShells = {
        default = with pkgs; mkShell { shellHook = ""; };
      };
    };
  };
}
