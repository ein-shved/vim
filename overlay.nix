final: prev: {
  vim-configured = final.nixvim.makeNixvimWithModule { module = import ./modules; };
  vim-configured-nodev = final.nixvim.makeNixvimWithModule {
    module = {
      imports = [
        ./modules
      ];
      setup.development = false;
    };
  };
}
