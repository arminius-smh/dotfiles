self: super:

{
  hexxit-server = super.callPackage ./hexxit-server { };
  bookmarker-menu = super.callPackage ./mpv-scripts/bookmarker-menu { };
  subs_to_clipboard = super.callPackage ./mpv-scripts/subs_to_clipboard { };
}
