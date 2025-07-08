// TODO: circularprogress for status
// need https://github.com/Aylur/astal/pull/282

import { Astal, Gtk } from "ags/gtk4"
import { exec, execAsync } from "ags/process"
import { createPoll } from "ags/time"
import Battery from "gi://AstalBattery"
import { createBinding, createState } from "ags"
import Popover from "./Popover"

export default function SysStatus() {
    const cpu = createPoll("0", 5000, ["bash", "-c", "awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else printf(\"%.2f\\n\", ($2+$4-u1) / (t-t1)); }' \
<(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat)"])

    const ram = createPoll("0", 3000, ["bash", "-c", "echo \"$(free | awk '/^Mem:/ {printf \"%.1f\\n\", $3 / 1024 / 1024}')\""])
    const ramTotal = Number(exec(['bash', '-c', "echo \"$(free | awk '/^Mem:/ {printf \"%.1f\\n\", $2 / 1024 / 1024}')\""]))

    const bat = Battery.get_default()
    const batPercentage = createBinding(bat, "percentage")

    const { TOP, RIGHT } = Astal.WindowAnchor
    const [visible1, setvisible1] = createState(false);

    <Popover
        visible={visible1}
        setvisible={setvisible1}
        marginTop={10}
        marginRight={40}
        anchor= { TOP | RIGHT }
    >
        <box class="StatusPopup" orientation={Gtk.Orientation.VERTICAL}>
            <box class="CPUStatusPopup">
                {/* <circularprogress value={cpu()} startAt={0} endAt={0} onDestroy={() => cpu.drop()}> */}
                    <image iconName={"cpu-symbolic"} />
                {/* </circularprogress> */}
                <box class="CPUStatusBox" hexpand orientation={Gtk.Orientation.VERTICAL}>
                    <label class="Heading" label={"cpu"} />
                    <label class="Text" label={cpu.as(cpu => (Number(cpu) * 100).toFixed(0) + "%")} />
                </box>
            </box>
            <box class="RAMStatusPopup">
                {/* <circularprogress value={bind(ram).as((val) => val / ramTotal)} startAt={0} endAt={0} onDestroy={() => ram.drop()}> */}
                    <image iconName={"ram-symbolic"} />
                {/* </circularprogress> */}
                <box class="RAMStatusBox" hexpand orientation={Gtk.Orientation.VERTICAL}>
                    <label class="Heading" label={"memory"} />
                    <label class="Text" label={ram.as((val) => `${val}G | ${ramTotal.toFixed(1)}G`)} />
                </box>
            </box>
            <box class="BatteryStatusPopup" visible={createBinding(bat, "isPresent")}>
                {/* <circularprogress value={bind(bat, "percentage")} startAt={0} endAt={0}> */}
                    <image iconName={"battery-symbolic"} />
                {/* </circularprogress> */}
                <box class="BatteryStatusBox" hexpand orientation={Gtk.Orientation.VERTICAL}>
                    <label class="Heading" label={"battery"} />
                    <label class="Text" label={batPercentage.as(p => `${Math.floor(p * 100)}%`)} />
                </box>
            </box>
        </box>
    </Popover>

    return <box
        $={(self) => {
            const clickController = new Gtk.GestureClick();
            clickController.set_button(0)
            clickController.connect('pressed', (_controller) => {
                const button = _controller.get_current_button();
                if (button === 1) { // 1 = left click
                    setvisible1(true)
                }
                if (button === 3) { // 3 = right click
                    execAsync(["bash", "-c", "missioncenter"])
                }

                // not sure why this is needed, otherwise left clicks only work once
                _controller.reset()
            });
            self.add_controller(clickController);
        }}
    >
        <box class="Status">
            <box class="CPU">
                {/* <circularprogress value={cpu()} startAt={0} endAt={0} onDestroy={() => cpu.drop()} tooltipText={bind(cpu).as(cpu => "cpu: " + (cpu * 100).toFixed(0) + "%")}> */}
                {/*     <icon /> */}
                {/* </circularprogress> */}
                <label label={cpu.as(cpu => { return "   " + (Number(cpu) * 100).toFixed(0) + "%" })}
                    tooltipText={cpu.as(cpu => "cpu: " + (Number(cpu) * 100).toFixed(0) + "%")}
                />
            </box>
            <box class="RAM">
                {/* <circularprogress value={bind(ram).as((val) => val / ramTotal)} startAt={0} endAt={0} onDestroy={() => ram.drop()} tooltipText={bind(ram).as(ram => "ram: " + (ram / ramTotal * 100).toFixed(0) + "%")}> */}
                {/*     <icon /> */}
                {/* </circularprogress> */}
                <label label={ram.as(ram => "   " + (Number(ram) / ramTotal * 100).toFixed(0) + "%")}
                    tooltipText={ram.as(ram => "ram: " + ram + "GB/" + ramTotal + "GB")}
                />
            </box>
            <box class="BatteryStatus" visible={createBinding(bat, "isPresent")}>
                {/* <circularprogress value={bind(bat, "percentage")} startAt={0} endAt={0} tooltipText={bind(bat, "percentage").as(p => `battery: ${Math.floor(p * 100)}%`)}> */}
                {/*     <icon /> */}
                {/* </circularprogress> */}
                <label label={batPercentage.as(bat => "󰁹  " + Math.floor(bat * 100) + "%")}
                    tooltipText={batPercentage.as(bat => `battery: ${Math.floor(bat * 100)}%`)}
                />
            </box>
        </box>
    </box>
}
