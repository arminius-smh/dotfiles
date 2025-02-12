import { bind, Variable } from "astal"

export default function RAM() {
    const ram = Variable<number>(0.0).poll(5000, ["bash", "-c", "free -m | awk '/Mem/{printf(\"%.2f\\n\"), $3/$2}'"])

    return <box className="RAM">
        <circularprogress value={ram()} startAt={0} endAt={0} onDestroy={() => ram.drop()} tooltipText={bind(ram).as(ram => "ram: " + (ram * 100).toFixed(0) + "%")}>
            <icon />
        </circularprogress>
    </box>
}

