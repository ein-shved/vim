{
  description = ''
    Vim configuration based on
    [nixvim](https://github.com/nix-community/nixvim?tab=readme-ov-file)
    and [NvChad](https://github.com/NvChad/NvChad)
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixvim.url = "github:nix-community/nixvim/nixos-24.11";
    nixvim.inputs = {
      nixpkgs.follows = "nixpkgs";
      home-manager.follows = "home-manager";
    };
  };

  outputs =
    { nixvim, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        nixvim' = nixvim.legacyPackages."${system}";
      in
      {
        packages = rec {
          nvim = nixvim'.makeNixvimWithModule { module = import ./modules; };
          neovim = nvim;
          vim = nvim;
          default = nvim;
          inherit (nixvim.packages."${system}") docs;
        };
      }
    )
    // {
      nixosModules =
        let
          nixvim-overlay =
            final: prev:
            let
              system = final.system;
            in
            {
              nixvim = nixvim.legacyPackages."${system}";
            };
        in
        rec {
          nvim = {
            nixpkgs.overlays = [
              nixvim-overlay
              (import ./overlay.nix)
            ];
          };
          neovim = nvim;
          vim = nvim;
          default = nvim;
        };
    };
}
