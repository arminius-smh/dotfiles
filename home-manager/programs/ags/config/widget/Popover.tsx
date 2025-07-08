import { Astal, Gtk, Gdk } from "ags/gtk4";
import { Setter, Accessor } from "ags";
import GObject from "gi://GObject?version=2.0";

type PopupWindowSpecificProps = {
    $?: (self: Astal.Window) => void;
    children?: GObject.Object;
    // this works, but can't be right...
    visible?: Accessor<boolean>;
    setvisible: Setter<boolean>;
};

type PopoverProps = Partial<Pick<
    Astal.Window.ConstructorProps,
    | "anchor"
    | "marginBottom"
    | "marginTop"
    | "marginLeft"
    | "marginRight"
    | "widthRequest"
    | "heightRequest"
>> & PopupWindowSpecificProps;

export default function Popover({
    visible,
    setvisible,
    children,
    anchor,
    marginBottom = 0,
    marginTop = 0,
    marginLeft = 0,
    marginRight = 0,
    widthRequest = 0,
    heightRequest = 0,
    ...props
}: PopoverProps): GObject.Object {


    // TODO: Gjs-Console-CRITICAL **: Error: out of tracking context: will not be able to cleanup (prob releated to the 'visible' stuff?)
    return <Astal.Window
        {...props}
        exclusivity={Astal.Exclusivity.NORMAL}
        keymode={Astal.Keymode.EXCLUSIVE}
        anchor={anchor}
        css={`window {
                margin-left: ${marginLeft}px;
                margin-right: ${marginRight}px;
                margin-top: ${marginTop}px;
                margin-bottom: ${marginBottom}px;
                background-color: transparent;
            }`}
        visible={visible}
        $={(self) => {
            const keyController = Gtk.EventControllerKey.new();
            const clickController = new Gtk.GestureClick();
            clickController.set_button(0)
            clickController.connect('pressed', (_controller, _, x, y) => {
                const width = self.get_allocated_width();
                const heigth = self.get_allocated_height();

                // TODO: Gtk-WARNING **: Broken accounting of active state for widget
                if (x > width || y > heigth || x < 0 || y < 0) {
                    setvisible(false);
                }
            })

            keyController.connect("key-pressed", (_, keyval) => {
                if (keyval === Gdk.KEY_Escape) {
                    setvisible(false);
                }

            })
            self.add_controller(keyController);
            self.add_controller(clickController);
        }}
    >

        <Gtk.Box>
            <Gtk.Box widthRequest={widthRequest} heightRequest={heightRequest}>
                {children}
            </Gtk.Box>
        </Gtk.Box>

    </Astal.Window>
}
