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
├── gaming-*.nix             # Configurations pour le jeu (commun, NVIDIA, AMD)
├── networking.nix           # Réseau et pare-feu
└── system.nix               # Services et entretien du système
```

Importer le dossier `modules` suffit : NixOS charge automatiquement son
fichier `default.nix`.

### Modules optionnels par défaut (`cifs.nix`, `gaming-amd.nix`, `gaming-nvidia.nix`)

Par défaut, certains modules spécifiques ou matériels ne sont **pas chargés** car commentés dans [`modules/default.nix`](modules/default.nix:1) :
- `cifs.nix` (montage de partages réseau)
- `gaming-amd.nix` (pilotes et paramètres graphiques pour cartes graphiques AMD)
- `gaming-nvidia.nix` (pilotes et paramètres graphiques pour cartes graphiques NVIDIA)

Pour les activer selon la configuration de votre machine, vous disposez de deux méthodes :

#### Méthode 1 : Décommenter directement dans `modules/default.nix`
Modifiez [`modules/default.nix`](modules/default.nix:1) pour décommenter la ligne correspondante :
```nix
  imports = [
    ./apps-core.nix
    ./apps-flatpak.nix
    ./apps-fonts.nix
    ./apps-gaming.nix
    ./boot.nix
    ./cifs.nix             # Activé
    ./desktop-dms.nix
    ./desktop-greetd.nix
    ./desktop-hyprland.nix
    ./gaming-common.nix
    ./gaming-nvidia.nix    # Activé pour une machine NVIDIA
    #./gaming-amd.nix
    ./imprimante.nix
    ./networking.nix
    ./system.nix
  ];
```

#### Méthode 2 : Importer spécifiquement depuis votre `configuration.nix` hôte
Si vous préférez garder le dépôt intact, vous pouvez importer le module directement depuis le fichier de configuration principal de votre machine (`/etc/nixos/configuration.nix`) :
```nix
  imports = [
    ./hardware-configuration.nix
    ./nixos-dms/modules            # Importe le socle commun
    ./nixos-dms/modules/cifs.nix   # Active CIFS sur cette machine
    ./nixos-dms/modules/gaming-amd.nix # Active les optimisations AMD sur cette machine
  ];
```

## Installation rapide (script automatisé)

```bash
curl -sSL https://raw.githubusercontent.com/DavidBrigand/nixos-dms/main/install.sh | bash
```

*(Ou en clonant manuellement le dépôt et en exécutant `./install.sh` depuis [`/etc/nixos/nixos-dms`](./install.sh))*.

## Script de mise à jour (`nix-up.sh`)

Le script [`nix-up.sh`](./nix-up.sh) permet de faire une mise à jour du système (`nixos-rebuild switch --upgrade`) tout en comparant la liste des paquets avant et après la mise à jour (via `nix-store`), affichant ainsi clairement les différences entre les deux versions.

```bash
./nix-up.sh
```

## Installation manuelle pas à pas

> **Flatpaks :** `apps-flatpak.nix` active automatiquement le support de Flatpak dans NixOS, ajoute le dépôt Flathub et installe l'application `easyflatpak` via un service systemd lors de chaque déploiement.

## Modules

| Fichier | Rôle |
| --- | --- |
| `modules/default.nix` | Liste centralisée des modules importés par le dépôt. |
| `modules/apps-core.nix` | Applications NixOS communes : Nautilus, Kitty, utilitaires Wayland, GVFS et montage de disques. |
| `modules/apps-flatpak.nix` | Active le support Flatpak, ajoute le dépôt Flathub et installe l'application `easyflatpak`. |
| `modules/apps-fonts.nix` | Polices Noto, Inter, JetBrains Mono Nerd Font et symboles Material. |
| `modules/apps-gaming.nix` | Applications et outils pour le jeu (Steam, Lutris, etc.). |
| [`modules/boot.nix`](modules/boot.nix:1) | Configuration du chargeur de démarrage et des options de kernel. |
| [`modules/cifs.nix`](modules/cifs.nix:1) | Montage de partages réseau CIFS / SMB. |
| [`modules/desktop-hyprland.nix`](modules/desktop-hyprland.nix:1) | Hyprland, XWayland, portails XDG et variables Wayland. |
| [`modules/desktop-dms.nix`](modules/desktop-dms.nix:1) | DMS depuis `nixpkgs-unstable` et ses fonctionnalités. |
| [`modules/desktop-greetd.nix`](modules/desktop-greetd.nix:1) | Écran de connexion DMS avec Hyprland et clavier français. |
| [`modules/gaming-amd.nix`](modules/gaming-amd.nix:1) | Paramètres graphiques et pilotes spécifiques au jeu sur AMD. |
| [`modules/gaming-common.nix`](modules/gaming-common.nix:1) | Paramètres communs pour le jeu (optimisations, etc.). |
| [`modules/gaming-nvidia.nix`](modules/gaming-nvidia.nix:1) | Paramètres graphiques et pilotes spécifiques au jeu sur NVIDIA. |
| `modules/imprimante.nix` | Configuration des services d'impression et pilotes. |
| `modules/networking.nix` | NetworkManager et pare-feu. Le nom d'hôte reste dans le `configuration.nix` de la machine. |
| `modules/system.nix` | PipeWire, Polkit, RTKit, nettoyage automatique du store Nix et activation future des flakes. |