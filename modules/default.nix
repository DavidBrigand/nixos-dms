{ ... }:

{
  imports = [
    ./networking.nix
    ./system.nix

    ./apps-core.nix
    ./apps-flatpak.nix
    ./apps-fonts.nix

    ./gaming-graphics.nix

    ./desktop-hyprland.nix
    ./desktop-dms.nix
    ./desktop-greetd.nix
  ];
}
