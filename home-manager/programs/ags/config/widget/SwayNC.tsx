import { subprocess, exec } from "ags/process"
import { With, createState } from "ags"
import { Gtk } from "ags/gtk4"

export default function SwayNC() {
    let [content, setContent] = createState("󰂚 ")

    subprocess("swaync-client -swb",
        (out) => {
            let swaync = JSON.parse(out)
            if (swaync.alt == "none") {
                setContent("󰂚 ")
            } else if (
                swaync.alt == "notification") {
                setContent("󰂚<span foreground='#d20f39'><small><sup> </sup></small></span>")
            }
            else if (swaync.alt == "dnd-notification" || swaync.alt == "dnd-none") {
                setContent("<span foreground='#7f849c'>󰂛 </span>")
            }
        }
    )

    return <box
        $={(self) => {
            const clickController = new Gtk.GestureClick();
            clickController.set_button(0)
            clickController.connect('pressed', (_controller) => {
                const button = _controller.get_current_button();
                if (button === 1) { // 1 = left click
                    exec(["bash", "-c", "swaync-client -t -sw"])
                }
                if (button === 3) { // 3 = right click
                    exec(["bash", "-c", "swaync-client -d -sw"])
                }

                // not sure why this is needed, otherwise left clicks only work once
                _controller.reset()
            });
            self.add_controller(clickController);
        }}

    >
        <With value={content}>
            {(content) => <label useMarkup={true} class="SwayNC" label={content} />}
        </With>
    </box>
}

