import { bind } from "astal"
import Hyprland from "gi://AstalHyprland"

export default function Workspaces() {
    const hypr = Hyprland.get_default()

    function transform(id: Number) {
        switch (id) {
            case 1:
                return "一"
            case 2:
                return "二"
            case 3:
                return "三"
            case 4:
                return "四"
            case 5:
                return "五"
            case 6:
                return "六"
            case 7:
                return "七"
            case 8:
                return "八"
            case 9:
                return "九"
            default:
                return id
        }

    }

    return <box className="Workspaces"> {bind(hypr, "workspaces").as(wss => wss.
        filter(ws => !(ws.id >= -99 && ws.id <= -2))
        .sort((a, b) => a.id - b.id)
        .map(ws => (
            <button
                className={bind(hypr, "focusedWorkspace").as(fw =>
                    ws === fw ? "focused" : "")}
                onClicked={() => ws.focus()}>
                <label
                    useMarkup={true}
                >
                    {bind(hypr, "focusedWorkspace").as(fw => fw.id == ws.id ? "<span foreground='#74c7ec'></span>" : transform(ws.id))}
                </label>

            </button>
        )))
    } </box>
}
