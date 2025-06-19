{ lib, ... }:
let
  niri-integration =
    cmd:
    ":silent !niri-integration vim ${cmd} >/dev/null 2>/dev/null &";
  mkIntegrationCmd = event: cmd: {
    inherit event;
    pattern = "*";
    command = niri-integration cmd;
  };
  mkIntegrations = lib.foldlAttrs (
    acc: event: cmd:
    acc ++ [ (mkIntegrationCmd event cmd) ]
  ) [ ];
in
{
  autoCmd = mkIntegrations {
    WinEnter = "shift";
    WinNew = "sync";
    WinClosed = "sync";
  };
}
