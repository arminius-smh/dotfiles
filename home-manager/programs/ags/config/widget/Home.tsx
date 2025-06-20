import { execAsync, exec, bind, Variable } from "astal"
import { Gtk } from "astal/gtk3"
import Popover from "./Popover"

export default function Home() {
    const idleInitStatus = Number(exec(['bash', '-c', "systemctl --user is-active --quiet hypridle && echo '1' || echo '0'"]))
    const idleActive = Variable<number>(0).poll(5000, (['bash', '-c', "systemctl --user is-active --quiet hypridle && echo '1' || echo '0'"]))
    const idleInit = Variable(true);

    if (idleInitStatus == 0) {
        idleInit.set(false)
    }

    const visible1 = Variable(false);


    const _popover1 = <Popover
        onClose={() => visible1.set(false)}
        visible={visible1()}
        marginTop={50}
        marginLeft={10}
        valign={Gtk.Align.START}
        halign={Gtk.Align.START}
    >
        <box className="HomePopup" vertical>
            <label className="Heading" label="Home" />
            <box className="Settings" halign={Gtk.Align.CENTER}>
                <label className="Idle" label="Idle" />
                <switch state={bind(idleActive).as(state => {
                    if (state == 0) {
                        return false
                    } else {
                        return true
                    }
                })} onNotifyActive={self => {
                    // ignore initial setting
                    // if I would use systemctl --user x hypridle directly
                    // it will execute again, not sure how I can only listen to mouseClick events
                    if (idleInit.get() == true) {
                        idleInit.set(false)
                        return
                    }

                    // check if hypridle is active before starting
                    // to mitigiate multiple-monitors(bars) and multiple executions when state changes
                    if (self.active) {
                        execAsync(["bash", "-c", `
                            if ! systemctl --user is-active --quiet hypridle; then
                                systemctl --user start hypridle &&
                                notify-send -e 'NixOS' 'Hypridle started' --icon=/home/armin/dotfiles/assets/pics/NixOS.png -t 2000
                            fi
                        `]);
                    } else {
                        execAsync(["bash", "-c", `
                            if systemctl --user is-active --quiet hypridle; then
                                systemctl --user stop hypridle &&
                                notify-send -e 'NixOS' 'Hypridle stopped' --icon=/home/armin/dotfiles/assets/pics/NixOS.png -t 2000
                            fi
                        `]);
                    }
                }} />
            </box>
            <label className="horziontalLine"/>
            <box className="Powermenu">
                <button
                    className="PowerButton"
                    label={"󰐥"}
                    onClick={() => { execAsync(["bash", "-c", "shutdown now"]) }}
                />
                <button
                    className="LockButton"
                    label={""}
                    onClick={() => { execAsync(["bash", "-c", "loginctl lock-session"]) }}
                />
                <button
                    className="RestartButton"
                    label={"󰜉"}
                    onClick={() => { execAsync(["bash", "-c", "restart"]) }}
                />
            </box>
        </box>
    </Popover>

    return <box className="Home">
        <button
            onClick={() => visible1.set(true)}
            label={" "}
        />
    </box>
}
