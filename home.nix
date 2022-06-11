{ config, pkgs, ... }:

{
  home = {
    username = "freopen";
    homeDirectory = "/home/freopen";
    stateVersion = "22.05";
  };
  programs = {
    home-manager.enable = true;
  };
}
