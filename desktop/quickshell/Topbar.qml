// Devarity Shell 0.5 — official brand integration.
// Purely visual micro-lines: labels are edition metadata, not fabricated telemetry.
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
    implicitHeight: 50
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

        // Small static interference marks. No flicker or heavy GPU effects.
        Repeater {
            model: Math.max(0, Math.floor(bar.width / 120))
            Rectangle {
                required property int index
                x: index * 120 + 60
                y: 1
                width: 1
                height: 3
                color: Theme.blue
                opacity: 0.24
            }
        }

        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1
            color: Theme.blue
            opacity: 0.5
        }

        Row {
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            Rectangle {
                id: brand
                width: 200
                height: 34
                radius: 2
                color: bar.menuOpen || brandMouse.containsMouse ? Theme.raised : Theme.surface
                border.width: 1
                border.color: bar.menuOpen ? Theme.blue : Theme.subtle

                Rectangle {
                    x: 0; y: 0
                    width: 3
                    height: parent.height
                    color: Theme.blue
                }

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 6
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 5
                    BrandMark { width: 36; height: 32 }
                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 1
                        Text {
                            text: "DEVARITY_OS"
                            font.family: Theme.mono; font.pixelSize: 13; font.bold: true
                            color: Theme.bone
                        }
                        Text {
                            text: "SYSTEM INTERFACE / 0.5"
                            font.family: Theme.mono; font.pixelSize: 8
                            color: Theme.muted
                        }
                    }
                }

                MouseArea {
                    id: brandMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: bar.menuRequested()
                }
                Behavior on color { ColorAnimation { duration: 110 } }
            }

            Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 3
                visible: bar.width > 780
                Text {
                    text: "DVR // SYSTEM-01"
                    font.family: Theme.mono; font.pixelSize: 9
                    color: Theme.bone
                }
                Text {
                    text: "ARCH / EXPERIMENTAL"
                    font.family: Theme.mono; font.pixelSize: 8
                    color: Theme.muted
                }
            }
        }

        Row {
            anchors.centerIn: parent
            spacing: 10
            visible: bar.width > 1110

            Rectangle { width: 16; height: 1; color: Theme.blue; anchors.verticalCenter: parent.verticalCenter }
            Text {
                text: "WAYLAND  //  LILITH"
                font.family: Theme.mono
                font.pixelSize: 11
                font.bold: true
                color: Theme.bone
            }
            Rectangle { width: 16; height: 1; color: Theme.blue; anchors.verticalCenter: parent.verticalCenter }
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: 14
            anchors.verticalCenter: parent.verticalCenter
            spacing: 12
            Rectangle {
                width: 1; height: 25
                color: Theme.subtle
                anchors.verticalCenter: parent.verticalCenter
            }
            Column {
                spacing: 3
                Text {
                    text: Qt.formatDateTime(clock.date, "dd.MM.yyyy")
                    color: Theme.muted
                    font.family: Theme.mono
                    font.pixelSize: 9
                }
                Text {
                    text: Qt.formatDateTime(clock.date, "hh:mm")
                    color: Theme.blue
                    font.family: Theme.mono
                    font.bold: true
                    font.pixelSize: 13
                }
            }
        }
    }
}
