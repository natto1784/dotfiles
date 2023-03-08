{ self, inputs, globalArgs, ... }:
let
  inherit (inputs) nixpkgs;

  commonModules = [
    ./modules/nvim
    globalArgs
  ];
  personalModules = [ ./modules/sound.nix ];
  serverModules = [ ./modules/minimal.nix ];
in
{
  flake.nixosConfigurations = {
    #Home laptop
    satori = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
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
      modules = [
        ./remilia
        inputs.mailserver.nixosModules.mailserver
        { nixpkgs.pkgs = self.legacyPackages.${system}; }
      ]
      ++ commonModules
      ++ serverModules;
    };
  };
}
