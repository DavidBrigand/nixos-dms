{ config, pkgs, ... }:
let
  all-users = builtins.attrNames config.users.users;
  normal-users = builtins.filter (user: config.users.users.${user}.isNormalUser == true) all-users;
in
{
  # Configure printer
  services.printing = {
    enable = true;
    startWhenNeeded = true;
    drivers = with pkgs; [
      gutenprint
    ];
  };

  # Enable autodiscovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  systemd.services.cups-browsed.enable = false;
}
