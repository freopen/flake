{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelPatches = [{
      name = "keyboard_patch";
      patch = builtins.fetchurl {
        url = "https://patchwork.kernel.org/series/658747/mbox/";
        sha256 = "1p6zri73g2i942wnvmgq7vgng9qm71nwprblaqzglpvc1vgf2s8q";
      };
    }];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
  };

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    xserver = {
      layout = "us,ru";
      xkbVariant = "altgr-intl,";
      xkbOptions = "compose:rctrl,grp:caps_toggle";
      libinput.enable = true;
    };
    printing.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  programs.sway.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nixpkgs.config.allowUnfree = true;

  fonts.fonts = [ pkgs.hack-font ];

  users.users.freopen = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages = with pkgs; [
      vim
      curl
      git
    ];
  };

  system.autoUpgrade = {
    # enable when keyboard patch is no longer needed.
    enable = false;
    dates = "daily";
    flake = "github:freopen/nixos";
  };

  system.copySystemConfiguration = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

