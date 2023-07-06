{ config, ... }:
{
  users.mutableUsers = false;
  users.users.root = {
    initialHashedPassword = "$6$8/ZJ0jr/BWf4at92$PmRuEML2eiCHcRe/vuc54xgSkU.T7bO6ljUqczhkpw3kAv1mTl.PLMOhRuG.yIiEklJGwcHq3szit4PPkZaEM0";
  };
  users.users.${config.machine.userName} = {
    inherit (config.machine) hashedPassword shell;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" ];
  };
  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;
  security.rtkit.enable = true;

}