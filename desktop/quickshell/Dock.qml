import QtQuick
import Quickshell
import "Theme.js" as Theme

PanelWindow {
    id: dock
    required property var modelData
    signal menuRequested()

    screen: modelData
    anchors { bottom: true }
    margins.bottom: 14
    implicitWidth: Math.min(420, Math.max(210, modelData.width - 24))
    implicitHeight: 68
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore

    Rectangle {
        anchors.fill: parent
        color: Theme.voidColor
        radius: 3
        border.width: 1
        border.color: Theme.blue

        Rectangle {
            x: 8; y: 8; width: 3; height: parent.height - 16
            color: Theme.blue
        }
        Row {
            anchors.centerIn: parent
            spacing: 8

            Repeater {
                model: [
                    { tag: "TERM", cmd: ["kitty"] },
                    { tag: "FILES", cmd: ["dolphin"] },
                    { tag: "APPS", cmd: [] },
                    { tag: "SEARCH", cmd: ["fuzzel"] }
                ]

                Rectangle {
                    id: action
                    required property var modelData
                    width: Math.min(94, (dock.width - 58) / 4)
                    height: 44
                    color: mouse.containsMouse ? Theme.raised : Theme.surface
                    border.color: mouse.containsMouse ? Theme.blue : Theme.subtle
                    radius: 2

                    Text {
                        anchors.centerIn: parent
                        text: action.modelData.tag
                        color: mouse.containsMouse ? Theme.blue : Theme.bone
                        font.family: Theme.mono
                        font.bold: true
                        font.pixelSize: 11
                    }
                    MouseArea {
                        id: mouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (action.modelData.tag === "APPS") dock.menuRequested()
                            else Quickshell.execDetached(action.modelData.cmd)
                        }
                    }
                    Behavior on color { ColorAnimation { duration: 100 } }
                }
            }
        }
    }
}
