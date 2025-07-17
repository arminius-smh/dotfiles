{ lib, ... }:
{
  services = {
    getty = {
      autologinUser = "armin";
    };
  };

  environment = {
    etc = {
      issue = lib.mkForce {
        text = "";
      };
    };
  };
}
