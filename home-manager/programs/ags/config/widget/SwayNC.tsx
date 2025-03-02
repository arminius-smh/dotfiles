import { Variable, bind, exec } from "astal"

export default function SwayNC() {
    type SwayNCData = {
        text: string;
        alt: string;
        tooltip: string;
        class: string;
    };

    let content = Variable("󰂚 ")

    const defaultSwayNCData: SwayNCData = {
        text: "0",
        alt: "none",
        tooltip: "",
        class: "none"
    };

    const swaync = Variable<SwayNCData>(defaultSwayNCData).watch(["bash", "-c", "swaync-client -swb"], (out) => {
        return JSON.parse(out)
    })

    swaync.subscribe((val) => {
        if (val.alt == "none") {
            content.set("󰂚 ")
        } else if (
            val.alt == "notification") {
            content.set("󰂚<span foreground='#d20f39'><small><sup> </sup></small></span>")
        }
        else if (val.alt == "dnd-notification" || val.alt == "dnd-none") {
            content.set("<span foreground='#7f849c'>󰂛 </span>")
        }
    })

    return <eventbox onClick={(_, event) => {
        if (event.button == 1) {
            exec(["bash", "-c", "swaync-client -t -sw"])
        } else if (event.button == 3) {
            exec(["bash", "-c", "swaync-client -d -sw"])
        }
    }}>
        <label
            useMarkup={true}
            className="SwayNC"
            onDestroy={() => swaync.drop()}
        >
            {bind(content)}
        </label>
    </eventbox>
}

