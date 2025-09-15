{ lib, ... }:
let
  niri-integration = cmd: ":silent !niri-integration vim ${cmd} >/dev/null 2>/dev/null &";

  mkIntegrationCmdPattern = event: pattern: cmd: {
    inherit event pattern;
    command = niri-integration cmd;
  };

  mkIntegrationCmd =
    event: cmd:
    if lib.isAttrs cmd then
      mkIntegrationCmdPattern event cmd.pattern cmd.cmd
    else
      mkIntegrationCmdPattern event "*" cmd;

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
    OptionSet = {
      pattern = "guifont";
      cmd = "sync";
    };
  };
}
