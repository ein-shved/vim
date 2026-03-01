{lib, ... }:
{
  options.setup.development = lib.mkEnableOption "development setup mode" // {
    default = true;
  };
}
