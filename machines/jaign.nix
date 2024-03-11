{ pkgs, ... }:
{
  imports = [
    ./common
  ];
  machine = {
    userName = "jaign";
    userEmail = "jaign@outlook.com";
    hashedPassword = "$y$j9T$gpOgMJEbOsPn69dHhNYhG/$oJs3IBxXrdzV.lh.dwgxsrWiMmzy9apVlhEPKp0.lj1";
    shell = pkgs.fish;
    editor = "nvim";
    browser = "firefox";
    terminal = "kitty";
    wallpaper = ../wallpaper/catppuccin/evening-sky.png;
    lockImage = ../wallpaper/catppuccin/windows-error.jpg;
  };
}
