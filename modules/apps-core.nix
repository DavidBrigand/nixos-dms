{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Gestionnaire de fichiers (Nautilus/GNOME Files) + extensions utiles
    nautilus
    nautilus-open-any-terminal
    file-roller        	# gestion des archives (zip, tar...)
    gnome-disk-utility  # équivalent GNOME Disks
    papers 		# Lecteur PDF Gnome

    # Terminal (léger, très adapté à Hyprland/Wayland)
    kitty

    # Utilitaires système essentiels
    networkmanagerapplet
    pavucontrol         # contrôle audio graphique
    brightnessctl       # luminosité
    playerctl           # contrôle lecture média
    wl-clipboard        # presse-papier Wayland

    # En ligne de commandes
    nmap
    pciutils
    usbutils
    git
    fastfetch
    dnsutils
    smbclient-ng
    micro                   # Editeur comme nano en mieux ;)
    bc                      # GNU software calculator
    gh                      # GitHub CLI tool

    # Web
    #discord
    #chromium
    teamviewer              # Ne pas oublier de demarrer le service
    thunderbird-latest
    # Utilitaires
    # keepassxc # Bug pas d'affichage des lecteurs reseaux passage en flatpak
    #tilix
    # Bureautique
    libreoffice-fresh
    hunspell
    hunspellDicts.fr-moderne
    #Virtualisation
    qemu                    # hyperviseur qemu
    quickemu                # Outils qemu voir https://github.com/quickemu-project/quickemu
    # Autres
    #celluloid
    vscodium
    samba                   # Test pour acces a partage copieur samba

    # Divers
    unzip
    adwaita-icon-theme
    xdg-utils
    bibata-cursors
  ];

# Firefox 100% Français
programs.firefox = {
  enable = true;
  # On ne garde que le français ici
  languagePacks = [ "fr" ];

  wrapperConfig = {
    pipewireSupport = true;
  };
  
  policies = {
  # On force uniquement le français au niveau du moteur
  RequestedLocales = [ "fr" ];
  SpellCheckingDictionaries = [ "fr" ];
  };
  
  preferences = {
  "intl.accept_languages" = "fr-fr,fr";
  "intl.locale.requested" = "fr";
  };

};

  # Active le service GVFS pour que Nautilus gère bien les montages, MTP, etc.
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  # Demarrer les services
  services.teamviewer.enable = true;
  services.samba.smbd.enable = true;
  services.samba.enable = true;
  services.samba.nmbd.enable = true;

###############################
# Parametres des applications #
###############################

#Alias Bash
programs.bash.shellAliases = {
        nix-switch="sudo nixos-rebuild switch";
        nix-list="nixos-rebuild list-generations";
        nix-clean="sudo nix-collect-garbage -d";
        nix-rollback="sudo nixos-rebuild switch --rollback";
        nix-upgrade="/bin/sh /etc/nixos/nixos-dms/nix-up.sh";
        monip="curl ipinfo.io/ip";
  };

#Horodatage du history en couleur ignore les doublons de commandes
environment.interactiveShellInit = ''
  export HISTTIMEFORMAT="$(echo -e '\e[1;34m%F \e[1;36m%T \e[0m')"
  export HISTSIZE=10000
  export HISTFILESIZE=20000
  export HISTCONTROL=ignoreboth
'';

#programs.bash = {
#  interactiveShellInit = ''
#    PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '
#  '';
#};

}
