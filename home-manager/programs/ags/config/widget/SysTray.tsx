import Tray from "gi://AstalTray"
import { createBinding, For } from "ags"
import { Gtk } from "ags/gtk4"

export default function SysTray() {

    const tray = Tray.get_default()

    const trayitems = createBinding(tray, "items").as(items => items
        .filter(item => (item.get_status() != Tray.Status.PASSIVE) && (item.get_title() != "blueman"))
        .sort((a, b) => a.id.localeCompare(b.id))
    )

    return <box class="SysTray">
        <For each={trayitems}>
            {item => <button
                $={(self) => {
                    const clickController = new Gtk.GestureClick();
                    clickController.set_button(0)
                    clickController.connect('pressed', (_controller) => {
                        const button = _controller.get_current_button();
                        if (button === 1) { // 1 = left click
                            item.activate(0, 0)
                        }
                        if (button === 3) { // 3 = right click
                            // TODO: Right Click 2 Times: Gtk-WARNING **: Broken accounting of active state for widget 0x10d1a10(GtkImage)

                            // idk, generated gtk4 version of the gtk3 code I don't understand
                            let popover = Gtk.PopoverMenu.new_from_model(item.menuModel);
                            popover.insert_action_group("dbusmenu", item.actionGroup);
                            popover.set_has_arrow(false)
                            popover.set_parent(self);
                            popover.set_autohide(true)
                            popover.popup();
                        }

                        // not sure why this is needed, otherwise left clicks only work once
                        _controller.reset()
                    });
                    self.add_controller(clickController);
                }}
                tooltipMarkup={item.get_tooltip_markup() != "" ? createBinding(item, "tooltipMarkup") : createBinding(item, "title")}
            >
                <image gicon={createBinding(item, "gicon")} />
            </button>}
        </For>
    </box>
}
