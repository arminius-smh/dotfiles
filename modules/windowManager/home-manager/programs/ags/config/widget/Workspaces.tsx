import { With, For, createBinding } from "ags"
import Hyprland from "gi://AstalHyprland"

function transform(id: number): string {
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
        case 10:
            return "十"
        default:
            return ""
    }

}

export default function Workspaces() {
    const hypr = Hyprland.get_default()

    const hyprWorkspaces = createBinding(hypr, "workspaces")
        .as(wss => wss
            .filter(ws => !(ws.id >= -99 && ws.id <= -2))
            .sort((ws_a, ws_b) => ws_a.id - ws_b.id))

    const hyprFocusedWorkspace = createBinding(hypr, "focusedWorkspace")

    // don't crash when not using hyprland
    if (hypr != null) {
        return <box class="Workspaces">
            <For each={hyprWorkspaces}>
                {(ws) => {
                    return <button onClicked={() => ws.focus()}>
                        <With value={hyprFocusedWorkspace}>
                            {(fw) => fw.id == ws.id ? <label useMarkup label="<span foreground='#74c7ec'></span>" /> : <label label={transform(ws.id)} />}
                        </With>
                    </button>
                }}
            </For>
        </box>
    } else {
        return <box />
    }

}
