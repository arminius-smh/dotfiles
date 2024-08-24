# inspired by https://gist.github.com/bashbunni/f6b04fc4703903a71ce9f70c58345106

pomo() {

    local work() {
        clear
        timer -f "$1"
        clear
        if [[ "$OSTYPE" == "darwin"* ]]; then
            osascript -e 'display notification "🌴" with title "Work Timer is up!" subtitle "Take a Break 😊"'
        fi
        (mpv --no-terminal "$DOTFILES_PATH/assets/sounds/notification.mp3" &)
    }

    local rest() {
        clear
        timer -f "$1"
        clear
        if [[ "$OSTYPE" == "darwin"* ]]; then
            osascript -e 'display notification "🚀" with title "Break Timer is up!" subtitle "Go Back to Work 😌"'
        fi
        (mpv --no-terminal "$DOTFILES_PATH/assets/sounds/notification.mp3" &)
    }

    local print_centered_text() {
        terminal_width=$(tput cols)
        text=$1
        padding=$(( (terminal_width - ${#text}) / 2 ))
        printf "%${padding}s%s\n" " " "$text"
    }

    local set_timer() {
        print_centered_text "enter work time (e.g. 25m) or default (25m)" | lolcat
        read work_time
        if [[ "$work_time" == "" ]]; then
            work_time="25m"
        fi
        print_centered_text "enter break time (e.g. 5m) or default (5m)" | lolcat
        read break_time
        if [[ "$break_time" == "" ]]; then
            break_time="5m"
        fi
    }

    local handle_input() {
        if [[ "$1" == "r" ]]; then
            set_timer
        elif [[ "$1" == "q" ]]; then
            exit 0
        fi
        return
    }

    clear
    if [[ "$1" == "interactive" ]]; then
        set_timer
    else
        work_time="$1"
        break_time="$2"
    fi
    print_centered_text "start to work?" | lolcat
    read

    while true; do
        work "$work_time"
        print_centered_text "do you want to take a break now? (r|q)" | lolcat
        read input
        handle_input "$input"
        rest "$break_time"
        print_centered_text "continue to work? (r|q)" | lolcat
        read input
        handle_input "$input"
    done
}
