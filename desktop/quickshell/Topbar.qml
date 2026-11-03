import QtQuick
import Quickshell
import "Theme.js" as Theme

PanelWindow {
    id: bar
    required property var modelData
    property bool menuOpen: false
    signal menuRequested()

    screen: modelData
    anchors { top: true; left: true; right: true }
    implicitHeight: 42
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.voidColor
        border.color: Theme.subtle
        border.width: 1

        Rectangle { width: parent.width; height: 2; color: Theme.blue; opacity: 0.7 }

        Rectangle {
            id: menuButton
            x: 10; y: 6
            width: 146; height: 29
            color: bar.menuOpen ? Theme.raised : Theme.surface
            border.color: bar.menuOpen ? Theme.blue : Theme.subtle
            radius: 2
            Text {
                anchors.centerIn: parent
                color: Theme.blue
                font.family: Theme.mono
                font.bold: true
                font.pixelSize: 12
                text: "▣  DEVARITY_"
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: bar.menuRequested()
            }
        }

        Row {
            anchors.centerIn: parent
            spacing: 14
            Text {
                text: "01 // WAYLAND"
                font.family: Theme.mono
                font.pixelSize: 11
                color: Theme.bone
            }
            Rectangle { width: 1; height: 13; color: Theme.subtle }
            Text {
                text: "LILITH / EXPERIMENTAL"
                font.family: Theme.mono
                font.pixelSize: 11
                color: Theme.muted
            }
        }

        Text {
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            text: Qt.formatDateTime(clock.date, "dd.MM.yy  hh:mm")
            font.family: Theme.mono
            font.pixelSize: 11
            color: Theme.blue
        }
    }
}
