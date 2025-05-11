import { execAsync, exec, bind, Variable } from "astal"
import { Gtk } from "astal/gtk3"
import Popover from "./Popover"

export default function Home() {
    const idleInitStatus = Number(exec(['bash', '-c', "systemctl --user is-active --quiet hypridle && echo '1' || echo '0'"]))
    const idleActive = Variable<number>(0).poll(5000, (['bash', '-c', "systemctl --user is-active --quiet hypridle && echo '1' || echo '0'"]))
    const idleInit = Variable(true);

    if(idleInitStatus==0){
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
            <box className="Settings">
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
                    // it will do execute again, not sure how I can only listen to mouseClick events
                    if (idleInit.get() == true) {
                        idleInit.set(false)
                        return
                    }

                    if (self.active) {
                        execAsync(["bash", "-c", `
                            systemctl --user start hypridle &&
                            notify-send -e 'NixOS' 'Hypridle started' --icon=/home/armin/dotfiles/assets/pics/NixOS.png -t 2000
                        `]);
                    } else {
                        execAsync(["bash", "-c", `
                            systemctl --user stop hypridle &&
                            notify-send -e 'NixOS' 'Hypridle stopped' --icon=/home/armin/dotfiles/assets/pics/NixOS.png -t 2000
                        `]);
                    }
                }} />
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
