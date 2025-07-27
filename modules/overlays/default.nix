{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      vimPlugins = (prev.vimPlugins or { }) // {
        noice-nvim = final.vimUtils.buildVimPlugin {
          pname = "noice.nvim";
          version = "2025-07-26";
          src = final.fetchFromGitHub {
            owner = "ein-shved";
            repo = "noice.nvim";
            rev = "4049eaac658a5ebb1fe4c05b5fa635ffca5e4e87";
            hash = "sha256-tgb89j2HjlEW+mpTRKPYeWXSL1cl1yMkGrs965+d850=";
          };
          meta.homepage = "https://github.com/folke/noice.nvim/";
          meta.hydraPlatforms = [ ];
          doCheck = false;
        };
        which-key-nvim = prev.vimPlugins.which-key-nvim.overrideAttrs {
          pname = "which-key.nvim";
          version = "2025-07-27";
          src = final.fetchFromGitHub {
            owner = "ein-shved";
            repo = "which-key.nvim";
            rev = "c3447128de0cdf4b74e90fd62b26514ab78ceace";
            hash = "sha256-RjC3lCFdaXXCTUFrbPKzUDWuYJwvFg+GZgpdcKU4zjw=";
          };
        };
      };
    })
  ];
}
