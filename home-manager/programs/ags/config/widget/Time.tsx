import { createPoll } from "ags/time"
import { Gtk } from "ags/gtk4"

export default function Time() {
    const time = createPoll("", 1000, "date +'<b>%H</b> : %M'")

    return <menubutton>
        <label
            class="Time"
            useMarkup
            label={time}
        />
        <popover>
            <Gtk.Calendar />
        </popover>
    </menubutton>
}
