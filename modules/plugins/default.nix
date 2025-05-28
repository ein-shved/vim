{ ... }:
{
  imports = [
    ./extras

    ./auto-session.nix
    ./cmp.nix
    ./comment.nix
    ./gitblame.nix
    ./gitgutter.nix
    ./lsp.nix
    ./neo-tree.nix
    ./telescope.nix
    ./treesitter.nix
    ./which-key.nix
  ];
  plugins = {
    web-devicons.enable = true;
  };
}
