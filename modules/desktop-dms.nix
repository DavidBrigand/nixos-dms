{ config, pkgs, ... }:

let
  unstable = import <unstable> {
    inherit (pkgs.stdenv.hostPlatform) system;
  };
in
{
    programs.dms-shell = {
    enable = true;

    # Utilise DMS depuis nixpkgs-unstable
    package = unstable.dms-shell;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    # Core features
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
  };
}
