{ config, pkgs, ... }:

{
  services.displayManager.dms-greeter = {
    enable = true;

    compositor = {
      name = "hyprland";

      customConfig = ''
        hl.env("DMS_RUN_GREETER", "1")

        hl.config({
          input = {
            kb_layout = "fr",
            kb_variant = "",
          },

          misc = {
            disable_hyprland_logo = true,
          },
        })
      '';
    };
  };
}
