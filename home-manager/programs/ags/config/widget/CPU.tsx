import { Variable, bind } from "astal"

export default function CPU() {
    const cpu = Variable<number>(0.0).poll(5000, ["bash", "-c", "awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else printf(\"%.2f\\n\", ($2+$4-u1) / (t-t1)); }' \
<(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat)"])

    return <box className="CPU">
        <circularprogress value={cpu()} startAt={0} endAt={0} onDestroy={() => cpu.drop()} tooltipText={bind(cpu).as(cpu => "cpu: " + (cpu * 100).toFixed(0) + "%")}>
            <icon />
        </circularprogress>
    </box>
}

