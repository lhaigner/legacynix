# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstablePkgs = import <nixos-unstable> { config.allowUnfree = true; };
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./wayland-configuration.nix
      ./sway-configuration.nix
    ];

  # Set your hostname.
  networking.hostName = "nixos";

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.utf8";
    LC_IDENTIFICATION = "de_AT.utf8";
    LC_MEASUREMENT = "de_AT.utf8";
    LC_MONETARY = "de_AT.utf8";
    LC_NAME = "de_AT.utf8";
    LC_NUMERIC = "de_AT.utf8";
    LC_PAPER = "de_AT.utf8";
    LC_TELEPHONE = "de_AT.utf8";
    LC_TIME = "de_AT.utf8";
  };

  # Configure keymap in X11.
  services.xserver = {
    enable = true;
    libinput.enable = true;
    layout = "us";
    displayManager.sddm.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.unnamed = {
    isNormalUser = true;
    description = "Unnamed";
    extraGroups = [ "networkmanager" "video" "wheel" ];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "unnamed";

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Enable flatpak.
  services.flatpak.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    appimage-run
    direnv
    element-desktop
    file
    firefox-wayland
    gimp
    git
    gnupg
    google-chrome
    jetbrains.webstorm
    keepassxc
    killall
    mpv
    nix-prefetch-git
    p7zip
    spotify
    steam-run
    teamspeak_client
    tor-browser-bundle-bin
    trackma-gtk
    unstablePkgs.discord
    veracrypt
    vscode
    wget
  ];

  # List fonts installed in system profile.
  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    font-awesome
    twemoji-color-font
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # Enable GPG daemon.
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
    enableSSHSupport = true;
  };

  # Install steam.
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # List services that you want to enable:

  # Enable smartcard daemon.
  services.pcscd.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
