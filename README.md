# NixOS · Hyprland · DankMaterialShell

Configuration NixOS personnelle, pensée pour servir de socle commun à plusieurs
machines. Le dépôt rassemble l'environnement graphique **Hyprland**,
**DankMaterialShell (DMS)**, les applications système et une sélection
d'applications Flatpak.

Les fichiers propres à une machine — matériel, chargeur de démarrage, nom
d'hôte, utilisateur, mot de passe et `system.stateVersion` — restent dans le
`configuration.nix` créé par l'installateur NixOS. Ils ne sont donc pas
versionnés ici.

## Organisation

```text
modules/
├── default.nix              # Point d'entrée : importe tous les modules
├── apps-*.nix               # Applications et polices
├── desktop-*.nix            # Hyprland, DMS et écran de connexion
├── gaming-graphics.nix      # Modèles de configuration graphique pour le jeu
├── networking.nix           # Réseau et pare-feu
└── system.nix               # Services et entretien du système
```

Importer le dossier `modules` suffit : NixOS charge automatiquement son
fichier `default.nix`.

## Installation sur une nouvelle machine

### 1. Installer NixOS normalement

Démarrer l'ISO NixOS et effectuer l'installation. L'installateur crée notamment
`/etc/nixos/configuration.nix` et `hardware-configuration.nix` pour le matériel
de la machine. Conserver ces deux fichiers.

### 2. Récupérer ce dépôt

Après le premier démarrage, récupérer le dépôt dans `/etc/nixos` (en utilisant `nix-shell` si `git` n'est pas installé par défaut) :

```bash
sudo nix-shell -p git --run "sudo git clone https://github.com/DavidBrigand/nixos-dms.git /etc/nixos/nixos-dms"
```

### 3. Adapter `configuration.nix`

Conserver la configuration matérielle générée et la configuration de base de l'installateur (qui définit déjà le nom d'hôte, l'utilisateur et la version d'état), puis ajouter simplement l'import du module dans la liste `imports` de `/etc/nixos/configuration.nix` :

```nix
imports = [
  ./hardware-configuration.nix
  ./nixos-dms/modules
];
```

### 4. Activer DMS depuis `nixpkgs-unstable`

À ce stade, `desktop-dms.nix` utilise le channel `unstable`. L'ajouter une fois
sur la machine :

```bash
sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable
sudo nix-channel --update
```

### 5. Appliquer la configuration

```bash
sudo nixos-rebuild switch
```

Après la première connexion à Hyprland, lancer `dms setup` dans un terminal
afin de créer les fichiers de configuration initiaux de DMS.

> **Flatpaks :** `apps-flatpak.nix` active automatiquement le support de Flatpak dans NixOS, ajoute le dépôt Flathub et installe l'application `easyflatpak` via un service systemd lors de chaque déploiement.

## Modules

| Fichier | Rôle |
| --- | --- |
| `modules/default.nix` | Liste centralisée des modules importés par le dépôt. |
| `modules/apps-core.nix` | Applications NixOS communes : Nautilus, Kitty, utilitaires Wayland, GVFS et montage de disques. |
| `modules/apps-flatpak.nix` | Active le support Flatpak, ajoute le dépôt Flathub et installe l'application `easyflatpak`. |
| `modules/apps-fonts.nix` | Polices Noto, Inter, JetBrains Mono Nerd Font et symboles Material. |
| `modules/desktop-hyprland.nix` | Hyprland, XWayland, portails XDG et variables Wayland. |
| `modules/desktop-dms.nix` | DMS depuis `nixpkgs-unstable` et ses fonctionnalités. |
| `modules/desktop-greetd.nix` | Écran de connexion DMS avec Hyprland et clavier français. |
| `modules/gaming-graphics.nix` | Blocs commentés pour les configurations jeu NVIDIA seule, AMD ou Intel. |
| `modules/networking.nix` | NetworkManager et pare-feu. Le nom d'hôte reste dans le `configuration.nix` de la machine. |
| `modules/system.nix` | PipeWire, Polkit, RTKit, nettoyage automatique du store Nix et activation future des flakes. |

## À venir

- Ajouter un `flake.nix` et un `flake.lock` pour verrouiller les versions de
  `nixpkgs-unstable` et `nix-flatpak`.
- Remplacer le channel `unstable` par une dépendance déclarative.
- Synchroniser le dépôt avec GitHub.
