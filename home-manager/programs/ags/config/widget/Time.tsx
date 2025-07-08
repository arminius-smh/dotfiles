import { createPoll } from "ags/time"

export default function Time() {
    const time = createPoll("", 1000, "date +'<b>%H</b> : %M'")

    return <label
        class="Time"
        useMarkup
        label={time}
    />
}
