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
            {/* TODO: Gjs-Console-CRITICAL **: Error: out of tracking context: will not be able to cleanup (switch stuff)*/}
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
                }}
            />
        </box>
        <label class="horziontalLine" />
        {/* NO idea why, but onClicked= leads to
        Gjs-Console-CRITICAL **: Error: out of tracking context: will not be able to cleanup
        $ - does not.
        */}
        <box class="Powermenu">
            <button
                class="PowerButton"
                label={"󰐥"}
                tooltipText="Power off"
                $={(self) => {
                    const clickController = new Gtk.GestureClick();
                    clickController.set_button(0)
                    clickController.connect('pressed', (_controller) => {
                        const button = _controller.get_current_button();
                        if (button === 1) { // 1 = left click
                            execAsync("shutdown now")
                        }
                        // not sure why this is needed, otherwise left clicks only work once
                        _controller.reset()
                    });
                    self.add_controller(clickController);
                }}
            />
            <button
                class="LockButton"
                label={""}
                tooltipText="Lock"
                $={(self) => {
                    const clickController = new Gtk.GestureClick();
                    clickController.set_button(0)
                    clickController.connect('pressed', (_controller) => {
                        const button = _controller.get_current_button();
                        if (button === 1) { // 1 = left click
                            execAsync("loginctl lock-session")
                        }
                        // not sure why this is needed, otherwise left clicks only work once
                        _controller.reset()
                    });
                    self.add_controller(clickController);
                }}
            />
            <button
                class="RestartButton"
                label={"󰜉"}
                tooltipText="Restart"
                $={(self) => {
                    const clickController = new Gtk.GestureClick();
                    clickController.set_button(0)
                    clickController.connect('pressed', (_controller) => {
                        const button = _controller.get_current_button();
                        if (button === 1) { // 1 = left click
                            execAsync("reboot")
                        }
                        // not sure why this is needed, otherwise left clicks only work once
                        _controller.reset()
                    });
                    self.add_controller(clickController);
                }}
            />
        </box>
        <box class="Powermenu">
            <button
                class="HibernateButton"
                label={""}
                tooltipText="Hibernate"
                $={(self) => {
                    const clickController = new Gtk.GestureClick();
                    clickController.set_button(0)
                    clickController.connect('pressed', (_controller) => {
                        const button = _controller.get_current_button();
                        if (button === 1) { // 1 = left click
                            execAsync("systemctl hibernate")
                        }
                        // not sure why this is needed, otherwise left clicks only work once
                        _controller.reset()
                    });
                    self.add_controller(clickController);
                }}
            />
            <button
                class="LogoutButton"
                label={"󰗽"}
                tooltipText="Logout"
                $={(self) => {
                    const clickController = new Gtk.GestureClick();
                    clickController.set_button(0)
                    clickController.connect('pressed', (_controller) => {
                        const button = _controller.get_current_button();
                        if (button === 1) { // 1 = left click
                            execAsync("uwsm stop")
                        }
                        // not sure why this is needed, otherwise left clicks only work once
                        _controller.reset()
                    });
                    self.add_controller(clickController);
                }}
            />
            <button
                class="SuspendButton"
                label={"󰤄"}
                tooltipText="Suspend"
                $={(self) => {
                    const clickController = new Gtk.GestureClick();
                    clickController.set_button(0)
                    clickController.connect('pressed', (_controller) => {
                        const button = _controller.get_current_button();
                        if (button === 1) { // 1 = left click
                            execAsync("systemctl suspend")
                        }
                        // not sure why this is needed, otherwise left clicks only work once
                        _controller.reset()
                    });
                    self.add_controller(clickController);
                }}
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
