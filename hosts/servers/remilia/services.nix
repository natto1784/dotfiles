{config, ...}:
{
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
  };
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJHingN2Aho+KGgEvBMjtoez+W1svl9uVoa4vG0d646j"
  ];
}
