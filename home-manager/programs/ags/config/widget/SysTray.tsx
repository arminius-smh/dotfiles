import Tray from "gi://AstalTray"
import { Gtk, Gdk, Astal } from "astal/gtk3"
import { bind } from "astal"

// doesn't work for bluetoothctl :/
export default function SysTray() {

    function clicky(self: Gtk.Widget, event: Astal.ClickEvent, item: Tray.TrayItem) {
        if (event.button == 1) { // left-click
            item.activate(0, 0)
        } else if (event.button == 3) { // right-click

            // idk what any of this is
            let menu = Gtk.Menu.new_from_model(item.menuModel)
            menu.insert_action_group("dbusmenu", item.actionGroup)
            menu.popup_at_widget(
                self,
                Gdk.Gravity.SOUTH,
                Gdk.Gravity.NORTH,
                null
            );
        }
    }
    const tray = Tray.get_default()

    return <box className="SysTray">
        {bind(tray, "items").as(items => items.filter(item => (item.get_status() != Tray.Status.PASSIVE) && (item.get_title() != "blueman")).map(item => (
            <button
                onClick={(self, event) => clicky(self, event, item)}
                tooltipMarkup={item.get_tooltip_markup() != "" ? bind(item, "tooltipMarkup") : bind(item, "title")}
            >
                <icon gicon={bind(item, "gicon")} />
            </button>
        )))}
    </box>
}

