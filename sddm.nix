{ config, lib, pkgs, ... }: {
  # SDDM still needs x11, it should be removed in a future release
  # Most of the bloat can probably be fixed with excludePackages
  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [
      xterm
      x11_ssh_askpass
    ];
  };

  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "${pkgs.catppuccin-sddm-corners}/share/sddm/themes/catppuccin-sddm-corners"; # Not including `Main.qml`, since SDDM does this automagically
    extraPackages = [
      pkgs.libsForQt5.qt5.qtgraphicaleffects
      #libsForQt5.qt5.qtsvg # Not needed?
    ];
  };
}
