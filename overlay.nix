final: prev: {
  vim-configured = final.nixvim.makeNixvimWithModule {
    module = {
      imports = [ ./modules ];
      nixpkgs.overlays = [
        (_: _: {
          inherit (final) niri-integration;
        })
      ];
    };
  };
}
