{
  description = ''
    Vim configuration based on
    [nixvim](https://github.com/nix-community/nixvim?tab=readme-ov-file)
    and [NvChad](https://github.com/NvChad/NvChad)
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    nixvim.url = "github:nix-community/nixvim/nixos-25.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    niri-integration.url = "github:ein-shved/niri-integration/vim";
  };

  outputs =
    {
      nixvim,
      flake-utils,
      niri-integration,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        nixvim' = nixvim.legacyPackages."${system}";
      in
      {
        packages = rec {
          nvim = nixvim'.makeNixvimWithModule {
            module = {
              imports = [
                ./modules
              ];
              nixpkgs.overlays = [
                (_: _: {
                  niri-integration = niri-integration.packages."${system}".default;
                })
              ];
            };
          };
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
              niri-integration = niri-integration.packages."${system}".default;
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
