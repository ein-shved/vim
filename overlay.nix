final: prev: {
  vim-configured = final.nixvim.makeNixvimWithModule { module = import ./modules; };
}
