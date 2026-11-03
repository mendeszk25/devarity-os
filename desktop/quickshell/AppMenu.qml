import QtQuick
import Quickshell
import Quickshell.Widgets
import "Theme.js" as Theme

PanelWindow {
    id: menu
    required property var modelData
    signal closeRequested()

    screen: modelData
    anchors { top: true; left: true }
    margins { top: 56; left: 12 }
    implicitWidth: Math.min(430, Math.max(250, modelData.width - 24))
    implicitHeight: Math.min(530, Math.max(210, modelData.height - 84))
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    focusable: true

    function launch(entry) {
        if (!entry) return
        // DesktopEntry.execute parses the desktop file; do not interpolate a shell command.
        entry.execute()
        menu.closeRequested()
    }

    onVisibleChanged: {
        if (visible) {
            search.text = ""
            search.forceActiveFocus()
        }
    }

    ScriptModel {
        id: filtered
        values: [...DesktopEntries.applications.values]
            .filter(e => e.name && e.name.toLowerCase().includes(search.text.toLowerCase()))
            .sort((a, b) => a.name.localeCompare(b.name))
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.voidColor
        radius: 2
        border.width: 1
        border.color: Theme.blue

        Column {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 8

            Row {
                width: parent.width
                height: 30
                spacing: 8
                Text {
                    text: "▣  APPLICATION INDEX"
                    font.family: Theme.mono; font.bold: true
                    color: Theme.blue; font.pixelSize: 13
                    anchors.verticalCenter: parent.verticalCenter
                }
                Item { width: Math.max(4, parent.width - 235); height: 1 }
                Text {
                    text: "[ CLOSE × ]"
                    color: Theme.muted
                    font.family: Theme.mono; font.pixelSize: 11
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: menu.closeRequested()
                    }
                }
            }

            Rectangle { width: parent.width; height: 1; color: Theme.subtle }

            Rectangle {
                width: parent.width; height: 42
                color: Theme.surface
                border.color: Theme.subtle
                TextInput {
                    id: search
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    verticalAlignment: TextInput.AlignVCenter
                    clip: true
                    font.family: Theme.mono; font.pixelSize: 13
                    color: Theme.bone
                    focus: true
                    selectByMouse: true
                    Keys.onEscapePressed: menu.closeRequested()
                    onAccepted: menu.launch(filtered.values.length ? filtered.values[0] : null)
                }
                Text {
                    anchors.fill: search
                    verticalAlignment: Text.AlignVCenter
                    text: "TYPE TO FILTER_"
                    font.family: Theme.mono; font.pixelSize: 12
                    color: Theme.muted
                    visible: search.text.length === 0
                    z: 1
                    enabled: false
                }
            }

            Text {
                text: String(filtered.values.length) + " INSTALLED ENTRIES // SELECT AN APPLICATION"
                font.family: Theme.mono; font.pixelSize: 10
                color: Theme.muted
                width: parent.width
                elide: Text.ElideRight
            }

            ListView {
                id: appList
                width: parent.width
                height: Math.max(0, parent.height - 157)
                model: filtered
                clip: true
                spacing: 3
                boundsBehavior: Flickable.StopAtBounds

                delegate: Rectangle {
                    id: entryRow
                    required property var modelData
                    width: ListView.view.width
                    height: 46
                    color: hit.containsMouse ? Theme.raised : Theme.surface
                    border.color: hit.containsMouse ? Theme.blue : Theme.subtle
                    radius: 2
                    Row {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 12
                        IconImage {
                            width: 24; height: 24
                            anchors.verticalCenter: parent.verticalCenter
                            source: Quickshell.iconPath(entryRow.modelData.icon, true)
                        }
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: entryRow.modelData.name
                            width: Math.max(0, entryRow.width - 75)
                            elide: Text.ElideRight
                            color: Theme.bone
                            font.family: Theme.mono
                            font.pixelSize: 12
                        }
                    }
                    MouseArea {
                        id: hit
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: menu.launch(entryRow.modelData)
                    }
                }
            }
            Rectangle { width: parent.width; height: 1; color: Theme.subtle }
            Text {
                text: "DEVARITY OS // ALPHA CHANNEL // ESC TO CLOSE"
                color: Theme.muted
                font.family: Theme.mono
                font.pixelSize: 10
            }
        }
    }
}
