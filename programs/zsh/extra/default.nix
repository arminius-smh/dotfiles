{...}: {
  programs = {
    zsh = {
      initExtra = builtins.readFile ./pomodoro.zsh;
    };
  };
}
