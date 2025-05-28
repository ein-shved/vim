{ ... }:
{
  imports = [
    ./clipboard.nix
    ./diagnostic.nix
    ./mappings.nix
    ./options.nix
  ];
  viAlias = true;
  vimAlias = true;
}
