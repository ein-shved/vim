final: prev:
{
  vim-configured = final.makeNixvimWithModule { module = import ./modules; };
}
