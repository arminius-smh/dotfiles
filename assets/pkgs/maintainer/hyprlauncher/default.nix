{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  glib,
  pango,
  gtk4,
  gtk4-layer-shell,
  wrapGAppsHook4,
}:

rustPlatform.buildRustPackage rec {
  pname = "hyprlauncher";
  version = "0.1.7";

  src = fetchFromGitHub {
    owner = "hyprutils";
    repo = "hyprlauncher";
    rev = "refs/tags/v${version}";
    hash = "sha256-waGYYUQ+PhG7YJMZRQdzobUAvoTx6WK/simGs35yqTc=";
  };

  cargoHash = "sha256-50+UOe6yVhXh5Aq8O0Ev+RvSXDhzIG9I7I0BRSaKoBY=";

  strictDeps = true;

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook4
  ];
  buildInputs = [
    glib
    pango
    gtk4
    gtk4-layer-shell
  ];

  meta = {
    description = "GUI for launching applications, written in Rust";
    homepage = "https://github.com/hyprutils/hyprlauncher";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ arminius-smh ];
    platforms = lib.platforms.linux;
    mainProgram = "hyprlauncher";
  };
}
