# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstablePkgs = import /home/unnamed/.nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./wayland-configuration.nix
      ./sway-configuration.nix
    ];

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    libinput.enable = true;
    layout = "us";
    displayManager.sddm = {
      enable = true;
      #theme = "${(pkgs.fetchFromGitHub {
      #  owner = "MarianArlt";
      #  repo = "kde-plasma-chili";
      #  rev = "a371123959676f608f01421398f7400a2f01ae06";
      #  sha256 = "17pkxpk4lfgm14yfwg6rw6zrkdpxilzv90s48s2hsicgl3vmyr3x";
      #})}";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.unnamed = {
    isNormalUser = true;
    description = "Unnamed";
    extraGroups = [ "networkmanager" "video" "wheel" ];
    packages = with pkgs; [];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "unnamed";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flatpak
  services.flatpak.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    element-desktop
    unstablePkgs.discord
    google-chrome
    spotify
    firefox-wayland
    vscode
    keepassxc
    teamspeak_client
    pavucontrol
    wget
    waybar
    killall
    nix-prefetch-git
    htop
    ranger
    # insomnia # doesn't work
    steam-run
    gimp
    mpv
    git
    direnv
    veracrypt
    jetbrains.webstorm
    gnupg
    file
    appimage-run
    p7zip
    pinentry-qt
    playerctl
    tor-browser-bundle-bin
    trackma-qt
  ];

  fonts.fonts = with pkgs; [
    font-awesome
    fira-code
    fira-code-symbols
    twemoji-color-font
  ];

  services.pcscd.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
    enableSSHSupport = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
