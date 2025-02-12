import { GLib, Variable } from "astal"

// thin-space in format
export default function Time({ format = "<b>%H</b> : %M" }) { 
    const time = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format(format)!)

    return <label
        className="Time"
        useMarkup={true}
        onDestroy={() => time.drop()}
        label={time()}
    />
}
