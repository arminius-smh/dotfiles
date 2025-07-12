import { Astal, Gtk } from "ags/gtk4";
import Popover from "./Popover"
import { createState } from "ags"

import { exec, execAsync } from "ags/process"

import { createPoll } from "ags/time"

const { TOP, LEFT } = Astal.WindowAnchor

const idleInitStatus = exec(['bash', '-c', "systemctl --user is-active --quiet hypridle && echo '1' || echo '0'"])
const idleActive = createPoll(idleInitStatus, 5000, ['bash', '-c', "systemctl --user is-active --quiet hypridle && echo '1' || echo '0'"]).as(state => {
    if (state === "0") {
        return false
    } else {
        return true
    }
})

const [visible1, setvisible1] = createState(false);

<Popover
    anchor={TOP | LEFT}
    marginTop={10}
    marginLeft={10}
    visible={visible1}
    setvisible={setvisible1}
>
    <box class="HomePopup" orientation={Gtk.Orientation.VERTICAL}>
        <label class="Heading" label="Home" />
        <box class="Settings" halign={Gtk.Align.CENTER}>
            <label class="Idle" label="Idle" />
            <switch
                active={idleActive}
                onNotifyActive={self => {
                    // check if hypridle is active before starting
                    // to mitigiate multiple-monitors(bars) and multiple executions when state changes
                    if (self.active) {
                        execAsync(["bash", "-c", `
                            if ! systemctl --user is-active --quiet hypridle; then
                                systemctl --user start hypridle &&
                                notify-send -e 'NixOS' 'Hypridle started' --icon=/home/armin/dotfiles/assets/pics/NixOS.png -t 1000
                            fi
                        `]);
                    } else {
                        execAsync(["bash", "-c", `
                            if systemctl --user is-active --quiet hypridle; then
                                systemctl --user stop hypridle &&
                                notify-send -e 'NixOS' 'Hypridle stopped' --icon=/home/armin/dotfiles/assets/pics/NixOS.png -t 1000
                            fi
                        `]);
                    }
                }} />
        </box>
        <label class="horziontalLine" />
        {/* TODO: Gjs-Console-CRITICAL **: Error: out of tracking context: will not be able to cleanup (exec stuff, idk) */}
        <box class="Powermenu">
            <button
                class="PowerButton"
                label={"󰐥"}
                onClicked={() => { execAsync(["bash", "-c", "shutdown now"]) }}
            />
            <button
                class="LockButton"
                label={""}
                onClicked={() => { execAsync(["bash", "-c", "loginctl lock-session"]) }}
            />
            <button
                class="RestartButton"
                label={"󰜉"}
                onClicked={() => { execAsync(["bash", "-c", "reboot"]) }}
            />
        </box>
    </box>
</Popover>

export default function Home() {
    return <box class="Home">
        <button
            onClicked={() => {
                setvisible1(true)
            }}
            label={" "}
        />
    </box>
}
