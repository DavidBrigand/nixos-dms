{ config, lib, pkgs, ... }:

{
  # Charger le module amdgpu tôt dans l'initrd (Early KMS pour AMD)
  # Cela permet à Plymouth de s'initialiser instantanément avec le bon pilote.
  boot.initrd.kernelModules = [
    "amdgpu"
  ];
}