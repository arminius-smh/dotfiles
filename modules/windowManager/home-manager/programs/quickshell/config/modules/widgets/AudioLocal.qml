import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell
import QtQuick.Layouts
import QtQuick.Controls

RowLayout {
    id: root
    property PwNode defaultSink: Pipewire.defaultAudioSink
    property PwNode defaultSource: Pipewire.defaultAudioSource

    Slider {
        id: slider
        from: 0.00
        to: 1.00
        value: {
            root.defaultSink == null ? 0 : root.defaultSink.audio.volume;
        }

        visible: false

        stepSize: 0.015

        implicitWidth: 0
        opacity: 0
        wheelEnabled: true

        handle: Rectangle {
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            implicitWidth: 12
            implicitHeight: 12
            radius: implicitWidth / 2
            color: "#6c7086"
        }

        onMoved: {
            root.defaultSink.audio.volume = slider.value;
        }
    }
    Item {
        Layout.preferredWidth: audioIcon.implicitWidth
        Layout.preferredHeight: audioIcon.implicitHeight

        Rectangle {
            anchors.right: parent.right
            color: "transparent"
            implicitWidth: root.implicitWidth
            implicitHeight: root.implicitHeight
            HoverHandler {
                id: hoverHandlerAudioIcon
            }
        }

        states: [
            State {
                name: "AudioIconHovered"
                when: hoverHandlerAudioIcon.hovered
                PropertyChanges {
                    target: slider
                    opacity: 1
                    implicitWidth: 120
                }
            }
        ]
        transitions: [
            Transition {
                from: ""
                to: "AudioIconHovered"
                NumberAnimation {
                    properties: "implicitWidth"
                    duration: 175
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    properties: "opacity"
                    duration: 175
                    easing.type: Easing.InOutQuad
                }
                onRunningChanged: {
                    if (running) {
                        slider.visible = true;
                    }
                }
            },
            Transition {
                from: "AudioIconHovered"
                to: ""
                NumberAnimation {
                    properties: "implicitWidth"
                    duration: 175
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    properties: "opacity"
                    duration: 175
                    easing.type: Easing.InOutQuad
                }
                onRunningChanged: {
                    if (!running) {
                        slider.visible = false;
                    }
                }
            }
        ]

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
                if (sink == null) {
                    return "";
                }
                const audio = sink.audio;
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
}
