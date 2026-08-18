{ config, pkgs, ... }:

{
  # Le nom d'hôte est propre à chaque machine : le définir dans configuration.nix.
  networking.networkmanager.enable = true;

  # Pare-feu activé par défaut, ouvre les ports ici si besoin plus tard
  networking.firewall.enable = true;
}
