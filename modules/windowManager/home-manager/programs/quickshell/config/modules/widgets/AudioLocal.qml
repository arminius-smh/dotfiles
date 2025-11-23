import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell
import QtQuick.Layouts

Item {
    id: root
    Layout.preferredWidth: audioIcon.implicitWidth
    Layout.preferredHeight: audioIcon.implicitHeight
    property PwNode defaultSink: Pipewire.defaultAudioSink
    property PwNode defaultSource: Pipewire.defaultAudioSource

    IconImage {
        id: audioIcon
        source: getVolumeIcon(root.defaultSink)
        implicitWidth: 25
        implicitHeight: 25

        MouseArea {
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            implicitHeight: parent.height
            implicitWidth: parent.width

            onClicked: mouse => {
                if (mouse.button == Qt.LeftButton) {
                    Quickshell.execDetached(["pwvucontrol"]);
                } else {
                    root.defaultSink.audio.muted = !root.defaultSink.audio.muted;
                }
            }

            onWheel: wheel => {
                const dy = wheel.angleDelta.y;
                const speaker = root.defaultSink.audio;

                if (dy <= 0) {
                    // scroll-down
                    speaker.volume = speaker.volume - 0.01 <= 0 ? 0 : speaker.volume - 0.01;
                } else {
                    speaker.volume = speaker.volume + 0.01 >= 1 ? 1 : speaker.volume + 0.01;
                }
            }
        }

        PwObjectTracker {
            objects: [root.defaultSink, root.defaultSource]
        }

        function getVolumeIcon(sink) {
            // at startup sink may be null until it is recognized
            if(sink == null){
                return ""
            }
            const audio = sink.audio
            if (audio.muted) {
                return `file:///home/armin/dotfiles/assets/pics/volume-mute.svg`;
            } else {
                if (audio.volume <= 0.30) {
                    return `file:///home/armin/dotfiles/assets/pics/volume-low.svg`;
                } else if (audio.volume <= 0.65) {
                    return `file:///home/armin/dotfiles/assets/pics/volume-medium.svg`;
                } else {
                    return `file:///home/armin/dotfiles/assets/pics/volume-high.svg`;
                }
            }
        }
    }
}
