{ ... }:
{
  programs = {
    zsh = {
      initContent = builtins.readFile ./pomodoro.zsh;
    };
  };
}
