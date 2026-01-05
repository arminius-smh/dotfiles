pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import Quickshell.Services.Mpris
import Quickshell.Widgets
import QtQuick.Layouts

Repeater {
    id: root
    model: Mpris.players.values.filter(pl => pl.dbusName == "org.mpris.MediaPlayer2.spotify" || pl.dbusName == "org.mpris.MediaPlayer2.Feishin")

    required property bool show
    property string lastActivePlayer: "org.mpris.MediaPlayer2.spotify"

    RowLayout {
        id: mprisContainer
        required property MprisPlayer modelData
        visible: root.show && root.lastActivePlayer === modelData.dbusName

        Connections {
            target: mprisContainer.modelData
            function onIsPlayingChanged() {
                const lastActive = root.model.find(item => item.dbusName === root.lastActivePlayer);
                const actives = root.model.filter(item => item.isPlaying === true).filter(pl => pl.dbusName != lastActive.dbusName);

                let playback = mprisContainer.modelData.isPlaying;

                if (playback == true) {
                    // if new player is playing, dont display change if last active player is still active
                    if (!lastActive.isPlaying) {
                        root.lastActivePlayer = mprisContainer.modelData.dbusName;
                    }
                } else if (root.lastActivePlayer === mprisContainer.modelData.dbusName) {
                    // if the active player was stopped,
                    // check if another one is still active and use that
                    // in case two players are active
                    if (!lastActive.isPlaying && actives.length > 0) {
                        root.lastActivePlayer = actives[0].dbusName;
                    }
                }
            }
        }

        states: [
            State {
                name: "MprisPlayerHovered"
                when: hoverHandlerMpris.hovered
                PropertyChanges {
                    target: playerControls
                    opacity: 1
                }
            }
        ]
        transitions: [
            Transition {
                from: ""
                to: "MprisPlayerHovered"
                NumberAnimation {
                    properties: "opacity"
                    duration: 175
                    easing.type: Easing.InOutQuad
                }
            },
            Transition {
                from: "MprisPlayerHovered"
                to: ""
                NumberAnimation {
                    properties: "opacity"
                    duration: 175
                    easing.type: Easing.InOutQuad
                }
            }
        ]

        // TODO: only margin right needed
        HoverHandler {
            id: hoverHandlerMpris
            margin: playerControls.implicitWidth
        }
        // https://forum.qt.io/topic/145956/rounded-image-in-qt6/6
        Item {
            Layout.preferredWidth: songImage.implicitWidth
            Layout.preferredHeight: songImage.implicitHeight

            MouseArea {
                acceptedButtons: Qt.LeftButton
                implicitHeight: parent.height
                implicitWidth: parent.width

                onClicked: mprisContainer.modelData.togglePlaying()
            }

            IconImage {
                id: songImage
                source: mprisContainer.modelData.trackArtUrl
                implicitWidth: 30
                implicitHeight: 30
                visible: false
            }

            MultiEffect {
                source: songImage
                anchors.fill: songImage
                maskEnabled: true
                maskSource: songImageMask
                maskThresholdMin: 0.5
                maskSpreadAtMin: 1.0
            }

            Item {
                id: songImageMask
                width: songImage.width
                height: songImage.height
                layer.enabled: true
                visible: false
                Rectangle {
                    width: songImage.width
                    height: songImage.height
                    radius: width / 2
                    color: "black"
                }
            }
        }

        Text {
            color: "#cdd6f4"
            text: songTitle(mprisContainer.modelData.trackTitle)
            leftPadding: 5
            font.family: "Lexend"

            function songTitle(title) {
                if (title.length > 38) {
                    title = title.substring(0, 35) + "...";
                }
                return title;
            }

            MouseArea {
                acceptedButtons: Qt.LeftButton
                implicitHeight: parent.height
                implicitWidth: parent.width

                onClicked: mprisContainer.modelData.togglePlaying()
            }
        }
        RowLayout {
            id: playerControls
            opacity: 0
            Layout.preferredWidth: 0

            Text {
                color: "#cdd6f4"
                font.pointSize: 14
                leftPadding: 3
                rightPadding: 5
                text: "󰒮"
                MouseArea {
                    acceptedButtons: Qt.LeftButton
                    implicitHeight: parent.height
                    implicitWidth: parent.width

                    onClicked: mprisContainer.modelData.previous()
                }
            }
            Text {
                color: "#cdd6f4"
                font.pointSize: 14
                rightPadding: 5
                text: playbackIcon(mprisContainer.modelData.playbackState)

                function playbackIcon(playback) {
                    if (playback == MprisPlaybackState.Playing) {
                        return "󰏤";
                    } else {
                        return "󰐊";
                    }
                }

                MouseArea {
                    acceptedButtons: Qt.LeftButton
                    implicitHeight: parent.height
                    implicitWidth: parent.width

                    onClicked: mprisContainer.modelData.togglePlaying()
                }
            }
            Text {
                color: "#cdd6f4"
                font.pointSize: 14
                text: "󰒭"
                MouseArea {
                    acceptedButtons: Qt.LeftButton
                    implicitHeight: parent.height
                    implicitWidth: parent.width

                    onClicked: mprisContainer.modelData.next()
                }
            }
        }
    }
}
