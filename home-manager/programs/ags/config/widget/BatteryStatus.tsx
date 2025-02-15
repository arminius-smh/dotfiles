import Battery from "gi://AstalBattery"
import { bind  } from "astal"

export default function BatteryStatus() {
    const bat = Battery.get_default()

    return <box className="BatteryStatus" visible={bind(bat, "isPresent")}>
        <circularprogress value={bind(bat, "percentage")} startAt={0} endAt={0} tooltipText={bind(bat, "percentage").as(p => `battery: ${Math.floor(p*100)} %`)}>
            <icon />
        </circularprogress>
    </box>
}
