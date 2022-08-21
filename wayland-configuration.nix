{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    gtkUsePortal = true;
  };

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DBUS_REMOTE = "1";
    XDG_CURRENT_DESKTOP = "sway"; 
    "_JAVA_AWT_WM_NONREPARENTING" = "1";
  };
}
