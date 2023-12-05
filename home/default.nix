{ config, pkgs, ... }:
let
  user = config.machine.userName;
in
{
  imports = [
    ./cli
    ./editor
    ./firefox
    ./language
    ./mpv
    ./obs-studio
    ./scripts
    ./shell
    ./terminal
    ./fcitx5
    ./music
  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      libsForQt5.kdenlive
    ];

    sessionVariables = {
      EDITOR = "hx";
      BROWSER = "firefox";
      TERMINAL = "foot";
      GTK_IM_MODULE = "";
      QT_IM_MODULE = "";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
    };
    sessionPath = [
      "$HOME/go/bin"
    ];
  };

  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "24.05";
}
