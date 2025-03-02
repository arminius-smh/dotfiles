import Bluetooth from "gi://AstalBluetooth"
import { execAsync, bind } from "astal"

export default function BluetoothStatus() {
    const bluetooth = Bluetooth.get_default()

    return <box className="BluetoothStatus" tooltipText={bind(bluetooth, "is_powered").as(val => {
        if (val == true) {
            return "Bluetooth Enabled"
        } else {
            return "Bluetooth Disabled"
        }
    })}>
        <button onClick={(_, event) => {
            if (event.button == 1) { // left-click
                execAsync(["bash", "-c", "blueman-manager"])
            } else if (event.button == 3) { // right-click
                bluetooth.toggle()
            }
        }}>
            <label className="bluetooth-icon" useMarkup={true}
                label={bind(bluetooth, "is_powered").as(val => {
                    if (val === true) {
                        return "󰂯"
                    } else {
                        return "<span foreground='#7f849c'>󰂲</span>"
                    }
                })} />
        </button>
    </box>
}

