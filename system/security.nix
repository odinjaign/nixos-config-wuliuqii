{ config, ... }:
{
  users.mutableUsers = false;
  users.users.root = {
    initialHashedPassword = "$y$j9T$x9n2iMY35uyQyi042WeMT0$Yb5GRz.2nZjE1RhTk4PS0XKmEvtMxAugg.q5aHQ5xl2";
  };
  users.users.${config.machine.userName} = {
    inherit (config.machine) hashedPassword shell;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" ];
  };

  security = {
    sudo.wheelNeedsPassword = false;
    # allow wayland lockers to unlock the screen
    pam.services = {
      hyprlock.text = "auth include login";
      greetd.enableGnomeKeyring = true;
    };

    # userland niceness
    rtkit.enable = true;

    polkit = {
      enable = true;

      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (action.id == "org.freedesktop.systemd1.manage-units") {
            if (action.lookup("unit") == "v2raya.service") {
              var verb = action.lookup("verb");
              if (verb == "start" || verb == "stop" || verb == "restart") {
                return polkit.Result.YES;
              }
            }
          }
        })
      '';
    };
  };
}
