(self: super: {
  vlc = super.vlc.override {
    libbluray = super.libbluray.override {
      withAACS = true;
      withBDplus = true;
    };
  };
})
