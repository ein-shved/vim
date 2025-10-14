{ ... }:
{
  imports = [
    ./extras

    ./aerial.nix
    ./auto-session.nix
    ./cmp.nix
    ./comment.nix
    ./gitblame.nix
    ./gitgutter.nix
    ./langmapper.nix
    ./lsp.nix
    ./lualine.nix
    ./neo-tree.nix
    ./noice.nix
    ./telescope.nix
    ./treesitter.nix
    ./which-key.nix
  ];
  plugins = {
    web-devicons.enable = true;
    markview.enable = true;
  };
}
