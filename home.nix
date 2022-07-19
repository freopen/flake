{ config, pkgs, ... }:
{
  home = {
    username = "freopen";
    homeDirectory = "/home/freopen";
    stateVersion = "22.05";
    packages = with pkgs; [
      firefox-wayland
      alacritty
      hack-font
      vscode
    ];
  };
  programs = {
    home-manager.enable = true;
  };
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      defaultWorkspace = "workspace number 1";
      terminal = "alacritty";
      window.titlebar = false;
    };
  };
}
