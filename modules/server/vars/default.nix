{ lib, config, ... }:

#define data for server variables
{
  options.serverData = {
    domain = lib.mkOption {
      type = lib.types.str;
      default = "bocchide.re";
      description = "My server domain";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "42507478+nayutadere@users.noreply.github.com";
    };
  };
}