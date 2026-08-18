{ ... }:

{
  # Ce module est importé mais n'active rien par défaut.
  # Décommente uniquement le bloc correspondant à la carte graphique du poste.

  # Base commune au jeu : accélération graphique et bibliothèques 32 bits.
  # hardware.graphics = {
  #   enable = true;
  #   enable32Bit = true;
  # };
  # programs.gamemode.enable = true;

  # NVIDIA — PC fixe avec une seule carte NVIDIA.
  # Nécessite les paquets non libres : décommente aussi la ligne allowUnfree.
  # nixpkgs.config.allowUnfree = true;
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   open = true; # RTX 20 / GTX 16 ou plus récent ; false pour les GPU plus anciens.
  #   nvidiaSettings = true;
  # };

  # AMD — carte Radeon ou circuit graphique AMD intégré.
  # Les pilotes Mesa/RADV sont sélectionnés automatiquement.
  # hardware.graphics = {
  #   enable = true;
  #   enable32Bit = true;
  # };

  # Intel — circuit graphique Intel intégré.
  # hardware.graphics = {
  #   enable = true;
  #   enable32Bit = true;
  # };

  # NVIDIA hybride (portable avec iGPU + NVIDIA) : volontairement non inclus.
  # Cette configuration nécessite les identifiants PCI propres à chaque machine.
}
