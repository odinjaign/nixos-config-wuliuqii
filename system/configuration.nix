{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./font.nix
      ./hardware.nix
      ./security.nix
      ./service.nix
      ./virtualisation.nix
      ./hyprland.nix
    ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    nameservers = [
      "119.29.29.29"
      "114.114.114.114"
      "223.5.5.5"
      "1.1.1.1"
    ];
    proxy = {
      default = "http://localhost:20172";
      noProxy = "127.0.0.1,localhost";
    };
  };

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      catppuccin-fcitx5
      # https://github.com/iDvel/rime-ice/issues/554
      (fcitx5-rime.override {
        librime = (pkgs.librime.overrideAttrs (old: {
          buildInputs = old.buildInputs ++ [ lua5_4 ];
        })).override {
          plugins = with pkgs; [ librime-lua ];
        };
        rimeDataPkgs = [
          (rime-ice.override {
            enableUnihan = true;
          })
          fcitx5-pinyin-moegirl
          fcitx5-pinyin-zhwiki
        ];
      })
    ];
  };

  sops.age.keyFile = "/home/${config.machine.userName}/.config/sops/age/keys.txt";

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      timeout = 3;
    };
    kernelParams = [
      "quiet"
      "splash"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  programs.fish.enable = true;
  environment = {
    shells = with pkgs; [ fish ];

    systemPackages = with pkgs; [
      networkmanagerapplet

      git
      wget
      nitch
      eza
      pciutils
      xdg-utils
    ];
  };

  nixpkgs.system = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"
        "https://hyprland.cachix.org/"
        "https://helix.cachix.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys =
        [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      auto-optimise-store = true; # Optimise syslinks
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  system = {
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "24.05";
  };
}
