import QtQuick
import QtQuick.Layouts
import Niri 0.1

Rectangle {
    id: root
    implicitWidth: rowLayout.implicitWidth + 5
    implicitHeight: 25
    Layout.rightMargin: 0
    color: "#00000000"
    radius: height / 2

    property var screenName

    Niri {
        id: niri
        Component.onCompleted: connect()
    }

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent

        Repeater {
            model: niri.workspaces

            Text {
                id: workspaceText
                visible: model.output == root.screenName && (model.activeWindowId != 0 || model.isActive)
                Layout.minimumWidth: 15

                text: workspaceTextFunc(model)
                color: workspaceColorFunc(model)

                property var workspaceId: model.id

                function workspaceColorFunc(mod) {
                    let color = "";
                    if (mod.isFocused) {
                        color = "#A7C080";
                    } else if (workspaceMouse.containsMouse) {
                        color = "#E67E80";
                    } else {
                        color = "#A7C080";
                    }
                    return color;
                }

                function workspaceTextFunc(mod) {
                    let icon = "";
                    if (mod.isFocused) {
                        icon = "";
                    } else if (mod.index == 9) {
                        icon = "";
                    } else {
                        icon = "";
                    }
                    return icon;
                }
                MouseArea {
                    id: workspaceMouse
                    hoverEnabled: true
                    acceptedButtons: Qt.LeftButton
                    anchors.fill: parent

                    onClicked: niri.focusWorkspaceById(workspaceText.workspaceId)
                }
            }
        }
    }
}
