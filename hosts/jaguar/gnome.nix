{config, lib, pkgs, ...}: {
  services.xserver.desktopManager.gnome.enable = true;

  # Disable conflicting services
  networking.networkmanager.enable = false;
  services.avahi.enable = false;
  hardware.pulseaudio.enable = false;
}