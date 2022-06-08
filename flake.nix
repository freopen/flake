{
  description = "Freopen's NixOS config.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations.desktop = {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
