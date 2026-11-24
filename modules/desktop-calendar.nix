{ config, pkgs, ... }:

let
  # Import de la branche unstable pour récupérer dankcalendar
  unstablePkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz") {
    inherit (pkgs.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };
in
{
  # Ajout de dankcalendar aux paquets système
  environment.systemPackages = [
    unstablePkgs.dankcalendar
  ];
}
