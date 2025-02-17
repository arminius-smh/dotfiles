import { Gtk } from "astal/gtk3"
import { Variable, bind, exec } from "astal"
import Battery from "gi://AstalBattery"
import Popover from "./Popover"

export default function CPU() {
    const cpu = Variable<number>(0.0).poll(5000, ["bash", "-c", "awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else printf(\"%.2f\\n\", ($2+$4-u1) / (t-t1)); }' \
<(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat)"])

    const ram = Variable<number>(0.0).poll(3000, ["bash", "-c", "echo \"$(free | awk '/^Mem:/ {printf \"%.1f\\n\", $3 / 1024 / 1024}')\""])
    const ramTotal = Number(exec(['bash', '-c', "echo \"$(free | awk '/^Mem:/ {printf \"%.1f\\n\", $2 / 1024 / 1024}')\""]))

    const bat = Battery.get_default()

    const visible1 = Variable(false);

    const _popover1 = <Popover
        onClose={() => visible1.set(false)}
        visible={visible1()}
        marginTop={50}
        marginRight={10}
        valign={Gtk.Align.START}
        halign={Gtk.Align.END}
    >
        <box className="StatusPopup" vertical>
            <box className="CPUStatusPopup">
                <circularprogress value={cpu()} startAt={0} endAt={0} onDestroy={() => cpu.drop()}>
                    <icon icon={"cpu-symbolic"} />
                </circularprogress>
                <box className="CPUStatusBox" vertical>
                    <label className="Heading" label={"cpu"} />
                    <label className="Text" label={bind(cpu).as(cpu => (cpu * 100).toFixed(0) + "%")} />
                </box>
            </box>
            <box className="RAMStatusPopup">
                <circularprogress value={bind(ram).as((val) => val/ramTotal)} startAt={0} endAt={0} onDestroy={() => ram.drop()}>
                    <icon icon={"ram-symbolic"} />
                </circularprogress>
                <box className="RAMStatusBox" vertical>
                    <label className="Heading" label={"memory"} />
                    <label className="Text" label={bind(ram).as((val) => `${val}G | ${ramTotal.toFixed(1)}G`)} />
                </box>
            </box>
            <box className="BatteryStatusPopup" visible={bind(bat, "isPresent")}>
                <circularprogress value={bind(bat, "percentage")} startAt={0} endAt={0}>
                    <icon icon={"battery-symbolic"} />
                </circularprogress>
                <box className="BatteryStatusBox" vertical>
                    <label className="Heading" label={"battery"} />
                    <label className="Text" label={bind(bat, "percentage").as(p => `${Math.floor(p * 100)}%`)} />
                </box>
            </box>
        </box>
    </Popover>

    return <eventbox onClick={() => visible1.set(true)}>
        <box className="Status">
            <box className="CPU">
                <circularprogress value={cpu()} startAt={0} endAt={0} onDestroy={() => cpu.drop()} tooltipText={bind(cpu).as(cpu => "cpu: " + (cpu * 100).toFixed(0) + "%")}>
                    <icon />
                </circularprogress>
            </box>
            <box className="RAM">
                <circularprogress value={bind(ram).as((val) => val/ramTotal)} startAt={0} endAt={0} onDestroy={() => ram.drop()} tooltipText={bind(ram).as(ram => "ram: " + (ram/ramTotal * 100).toFixed(0) + "%")}>
                    <icon />
                </circularprogress>
            </box>
            <box className="BatteryStatus" visible={bind(bat, "isPresent")}>
                <circularprogress value={bind(bat, "percentage")} startAt={0} endAt={0} tooltipText={bind(bat, "percentage").as(p => `battery: ${Math.floor(p * 100)}%`)}>
                    <icon />
                </circularprogress>
            </box>
        </box>
    </eventbox>
}

