{
  lib,
  pkgs,
  ...
}:
let
  lsp-format-modifications-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "lsp-format-modifications.nvim";
    version = "2025-07-05";
    dependencies = [ pkgs.vimPlugins.plenary-nvim ];
    src = pkgs.fetchFromGitHub {
      owner = "joechrisellis";
      repo = "lsp-format-modifications.nvim";
      rev = "fd2b0de0afa42bea1d310af8337a4a95ebd27260";
      sha256 = "1wmahg6dmjv1m64pr65fg912ma6dcnsnb34cdpk40jmdc6szl7pz";
    };
    meta.homepage = "https://github.com/joechrisellis/lsp-format-modifications.nvim/";
    meta.hydraPlatforms = [ ];
  };
in
lib.nixvim.plugins.mkNeovimPlugin {
  name = "lsp-format-modifications";
  package = lib.mkOption {
    type = lib.types.package;
    default = lsp-format-modifications-nvim;
  };
  callSetup = false;

  maintainers = [ lib.maintainers.shved ];
  url = "https://github.com/joechrisellis/lsp-format-modifications.nvim";
  description = "LSP formatting, but only on modified text regions.";
}
