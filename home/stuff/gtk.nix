{config, pkgs,...}:
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Gruvbox-Material-Dark";
      package = pkgs.gruvbox-icons;
    };
    theme = {
      name = "Equilux";
      package = pkgs.equilux-theme;
    };
 /*   gtk3 = {
      bookmarks = [
        "folder:///mnt/Stuff/Memes/Discord"
      ];
    };*/
  };
}
