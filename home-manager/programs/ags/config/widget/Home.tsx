export default function Home() {
    return <box className="Home">
        <button
            onClick={["bash", "-c", "$HOME/dotfiles/home-manager/programs/rofi/scripts/powermenu.sh"]}
            label={" "}
        />
    </box>
}

