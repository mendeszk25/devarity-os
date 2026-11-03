// Devarity Shell 0.6 — branded underground command dock.
// Four real actions, no placeholder buttons.
import QtQuick
import Quickshell
import "Theme.js" as Theme

PanelWindow {
    id: dock
    required property var modelData
    signal menuRequested()

    screen: modelData
    anchors { bottom: true }
    margins.bottom: 16
    implicitWidth: Math.min(464, Math.max(260, modelData.width - 28))
    implicitHeight: 84
    color: "transparent"
    // Intentionally overlays the floating canvas; reserve-zone behavior needs Lilith-specific testing.
    exclusionMode: ExclusionMode.Ignore

    Rectangle {
        anchors.fill: parent
        color: Theme.voidColor
        radius: 2
        border.width: 1
        border.color: Theme.subtle

        // CRT accent borders, static and deliberately restrained.
        Rectangle { x: 0; y: 0; width: 3; height: parent.height; color: Theme.blue }
        Rectangle { x: 0; y: 0; width: 56; height: 1; color: Theme.blue }
        Rectangle { x: parent.width - 54; y: parent.height - 1; width: 54; height: 1; color: Theme.blue }

        Row {
            x: 12; y: 2
            spacing: 6
            BrandMark { width: 26; height: 26 }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "DEVARITY // QUICK ACCESS"
                font.family: Theme.mono
                font.pixelSize: 9
                color: Theme.muted
            }
        }
        Text {
            anchors.right: parent.right
            anchors.rightMargin: 15
            y: 8
            text: "DVR/04"
            font.family: Theme.mono
            font.pixelSize: 9
            color: Theme.blue
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 9
            spacing: 7

            Repeater {
                model: [
                    { tag: "TERM", index: "01", cmd: ["kitty"] },
                    { tag: "FILES", index: "02", cmd: ["dolphin"] },
                    { tag: "APPS", index: "03", cmd: [] },
                    { tag: "SEARCH", index: "04", cmd: ["fuzzel"] }
                ]
                Rectangle {
                    id: action
                    required property var modelData
                    width: Math.max(47, (dock.width - 55) / 4)
                    height: 47
                    radius: 1
                    color: mouse.containsMouse ? Theme.raised : Theme.surface
                    border.width: 1
                    border.color: mouse.containsMouse ? Theme.blue : Theme.subtle
                    scale: mouse.containsMouse ? 1.025 : 1.0
                    transformOrigin: Item.Center

                    Text {
                        x: 7; y: 5
                        text: action.modelData.index
                        color: mouse.containsMouse ? Theme.blue : Theme.muted
                        font.family: Theme.mono
                        font.pixelSize: 8
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 4
                        text: action.modelData.tag
                        color: mouse.containsMouse ? Theme.blue : Theme.bone
                        font.family: Theme.mono
                        font.bold: true
                        font.pixelSize: 11
                    }
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 2
                        color: Theme.blue
                        visible: mouse.containsMouse
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
                    Behavior on color { ColorAnimation { duration: 110 } }
                    Behavior on scale { NumberAnimation { duration: 110 } }
                }
            }
        }
    }
    TechFrame { anchors.fill: parent; compact: true }
}
