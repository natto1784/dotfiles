{ config, ... }: {
  age =
    let
      home = config.home.homeDirectory;
    in
    {
      sshKeyPaths = [ "${home}/.ssh/id_ed25519" ];
      secrets = {
        mpdasrc = {
          file = ./mpdasrc.age;
          path = "${home}/.config/mpdasrc";
        };
        zshrc = {
          file = ./.zshrc.age;
          path = "${home}/.zshrc";
          mode = "660";
        };
        gitconfig = {
          file = ./.gitconfig.age;
          path = "${home}/.gitconfig";
          mode = "660";
        };
      };
    };
}
