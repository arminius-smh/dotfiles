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
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "hyprutils";
    repo = "hyprlauncher";
    rev = "refs/tags/v${version}";
    hash = "sha256-J0obh5QlJLJqAXn1XhHe8mN778z5o2RHbHvmkfZIzME=";
  };

  cargoHash = "sha256-k9DNY2kEalJsq/KC3J8FBXuk4Sk+h1zGrZJYIGyRv1M=";

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
