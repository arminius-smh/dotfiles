import Bluetooth from "gi://AstalBluetooth"
import { execAsync } from "ags/process"
import { createBinding } from "ags"
import { Gtk } from "ags/gtk4"

export default function BluetoothStatus() {
    const bluetooth = Bluetooth.get_default()

    return <box class="BluetoothStatus" tooltipText={createBinding(bluetooth, "is_powered").as(val => {
        if (val == true) {
            return "Bluetooth Enabled"
        } else {
            return "Bluetooth Disabled"
        }
    })}>
        <button
            $={(self) => {
                const clickController = new Gtk.GestureClick();
                clickController.set_button(0)
                clickController.connect('pressed', (_controller) => {
                    const button = _controller.get_current_button();
                    if (button === 1) { // 1 = left click
                        execAsync("blueman-manager")
                    }
                    if (button === 3) { // 3 = right click
                        bluetooth.toggle()
                    }

                    // not sure why this is needed, otherwise left clicks only work once
                    _controller.reset()
                });
                self.add_controller(clickController);
            }}

        >
            <label class="bluetooth-icon" useMarkup={true}
                label={createBinding(bluetooth, "is_powered").as(val => {
                    if (val === true) {
                        return "󰂯"
                    } else {
                        return "<span foreground='#7f849c'>󰂲</span>"
                    }
                })} />
        </button>
    </box>
}

