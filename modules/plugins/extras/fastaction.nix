{
  config,
  helpers,
  pkgs,
  ...
}:
helpers.neovim-plugin.mkNeovimPlugin config rec {
  name = "fastaction";
  defaultPackage = pkgs.vimUtils.buildVimPlugin {
    inherit name;
    src = pkgs.fetchFromGitHub {
      owner = "Chaitanyabsprip";
      repo = "fastaction.nvim";
      rev = "v1.2.1";
      hash = "sha256-2UuEORFTj4+gbuEm1D2FHXrRiU3pDsS5NG50Q9I1wuk=";
    };
  };
  callSetup = true;
  maintainers = [ ];
}
