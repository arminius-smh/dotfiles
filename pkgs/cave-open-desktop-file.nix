{ pkgs }:

pkgs.writeShellApplication {
  name = "cave-open-desktop-file";

  runtimeInputs = with pkgs; [ toybox ];

  text = ''
     NAME=$1
     for f in "$HOME"/.local/share/applications/*; do
            echo "$f"
            NAME_APP=$(grep "Name" "$f" | cut -d "=" -f 2)
            if [[ "$NAME_APP" == "$NAME" ]]; then
                EXEC=$(grep "Exec" "$f" | cut -d "=" -f 2-)
                # shellcheck disable=SC2086
                # nohup $EXEC >/dev/null 2>&1 &
                $EXEC
            fi
    done
  '';
}
