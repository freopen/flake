{ config, pkgs, ... }:

{
  home = {
    username = "freopen";
    homeDirectory = "/home/freopen";
    stateVersion = "22.05";
    packages = with pkgs; [
      firefox
      alacritty
      hack-font
    ];
  };
  programs = {
    home-manager.enable = true;
    neovim = {
      enable = true;
    };
  };
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      defaultWorkspace = "workspace number 1";
      terminal = "alacritty";
      window.titlebar = false;
    };
  };
}
