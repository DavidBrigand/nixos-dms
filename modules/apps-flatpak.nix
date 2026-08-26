{ config, pkgs, lib, ... }:
let
  flatpakPackages = [
    "org.mozilla.firefox"                 # Firefox
    "org.keepassxc.KeePassXC"             # Gestionnaire de mots de passe
    "io.github.totoshko88.RustConn"       # Gestionnaire de connexions distantes
    "io.github.kolunmi.Bazaar"            # Logithèque Flatpak
    "com.github.tchx84.Flatseal"          # Gestion des permissions Flatpak
    "com.heroicgameslauncher.hgl"         # Heroic Games Launcher
    "com.visualstudio.code"               # Visual Studio Code
    "org.mozilla.Thunderbird"             # Thunderbird
    "org.filezillaproject.Filezilla"      # FileZilla
  ];
in
{
  services.flatpak.enable = true;

  # Service systemd (et non un activationScript) : il attend que le réseau
  # et D-Bus soient réellement prêts avant de s'exécuter, contrairement aux
  # activationScripts qui tournent trop tôt pendant l'activation du système.
  systemd.services.install-flatpaks = {
    description = "Installation déclarative des paquets Flatpak";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "dbus.service" ];
    wants = [ "network-online.target" ];

    path = [ pkgs.flatpak ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true; # évite de le relancer à chaque démarrage une fois fait
    };

    script = ''
      set -eu

      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

      ${lib.concatMapStringsSep "\n" (pkg: ''
        echo "Installation de ${pkg}..."
        flatpak install -y flathub "${pkg}" || echo "Échec pour ${pkg}, on continue"
      '') flatpakPackages}
    '';
  };
}
