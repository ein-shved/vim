{ config, ... }:
{
  plugins.gitgutter = {
    enable = config.setup.development;
  };
}
