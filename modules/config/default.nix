{ ... }:
{
  imports = [
    ./clipboard.nix
    ./diagnostic.nix
    ./mappings.nix
    ./options.nix
    ./niri-integration.nix
  ];
  viAlias = true;
  vimAlias = true;
}
