{
  # no idea what this is, if this changes, just set it to 0 and force the config ig
  "cache.browsers/chrome-windows.json" = 1740832656248;
  ua = "";
  exactMatch = false;
  faqs = true;
  userAgentData = true;
  log = false;
  cache = true;
  blacklist = [ ];
  whitelist = [ ];
  # aarch64 netflix requires chromeos useragent
  custom = {
    "www.netflix.com, www.whatmyuseragent.com" =
      "Mozilla/5.0 (X11; CrOS aarch64 15236.80.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.5414.125 Safari/537.36";
  };
  parser = { };
  siblings = { };
  mode = "custom";
  protected = [
    "google.com/recaptcha"
    "gstatic.com/recaptcha"
    "accounts.google.com"
    "accounts.youtube.com"
    "gitlab.com/users/sign_in"
  ];
}
