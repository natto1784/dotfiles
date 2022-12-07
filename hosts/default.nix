{ self, inputs, ... }:
let
  inherit (inputs) nixpkgs;
  specialArgs = { inherit inputs; };

  commonModules = [ ./modules/nvim ];
  personalModules = [ ./modules/sound.nix ];
  serverModules = [
    ./modules/minpkgs.nix
    ./modules/minzsh.nix
  ];
  builders = [
    ./modules/x86builder.nix
  ];
in
{
  flake.nixosConfigurations = {
    #Home laptop
    satori = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      inherit specialArgs;
      modules = [
        ./satori
        { nixpkgs.pkgs = self.legacyPackages.${system}; }
      ]
      ++ personalModules
      ++ commonModules;
    };

    #Home server (RPi4)
    marisa = nixpkgs.lib.nixosSystem rec {
      system = "aarch64-linux";
      inherit specialArgs;
      modules = [
        ./marisa
        { nixpkgs.pkgs = self.legacyPackages.${system}; }
      ]
      ++ commonModules
      ++ serverModules;
    };

    #Oracle Cloud VM
    remilia = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      inherit specialArgs;
      modules = [
        ./remilia
        inputs.mailserver.nixosModules.mailserver
        { nixpkgs.pkgs = self.legacyPackages.${system}; }
      ]
      ++ commonModules
      ++ serverModules
      ++ builders;
    };
  };
}
