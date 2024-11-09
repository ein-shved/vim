{
  description = ''
    Vim configuration based on
    [nixvim](https://github.com/nix-community/nixvim?tab=readme-ov-file)
    and [NvChad](https://github.com/NvChad/NvChad)
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixvim.url = "github:nix-community/nixvim/nixos-24.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixvim, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        nixvim' = nixvim.legacyPackages."${system}";
      in
      {
        packages = nixvim.packages."${system}" // rec {
          nvim = nixvim'.makeNixvimWithModule { module = import ./modules; };
          neovim = nvim;
          vim = nvim;
          default = nvim;
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
