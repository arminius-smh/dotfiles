import { Variable } from "astal"

export default function RAM() {
    const ram = Variable<string>("  0%").poll(5000, ["bash", "-c", "free -m | awk '/Mem/{printf(\"  %d%%\\n\"), $3/$2*100}'"])

    return <label
        className="RAM"
        onDestroy={() => ram.drop()}
        label={ram()}
    />
}

