{ pkgs, ... }:
let
  overriden = pkgs.neovim-unwrapped.overrideAttrs (
    final: prev: {
      pathces = (final.patches or [ ]) ++ [
        ./0001-fix-lsp-handle-out-of-bounds-character-positions-302.patch
      ];
    }
  );
in
{
  package = overriden;
}
