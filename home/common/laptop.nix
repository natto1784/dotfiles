{ lib, ... }:
{
  options.isLaptop = lib.mkOption {
    type = lib.types.bool;
    default = false;
    example = true;
    description = "Whether this device is a laptop or not";
  };
}
