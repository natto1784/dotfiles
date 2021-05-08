{config, pkgs,...}:
{
  gtk = {
    enable = true;
    iconTheme.name = "Gruvbox-Material-Dark";
    iconTheme.package = pkgs.gruvbox-icons;
    theme.name = "Equilux";
    theme.package = pkgs.equilux-theme;
  };
}
