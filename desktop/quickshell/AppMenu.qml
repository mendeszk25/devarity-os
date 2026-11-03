// DEVARITY OS / APPLICATION INDEX v0.3
// Offline local desktop entries, no external network or shell string interpolation.
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
    implicitWidth: Math.min(480, Math.max(300, modelData.width - 24))
    implicitHeight: Math.min(564, Math.max(250, modelData.height - 90))
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    focusable: true

    function launch(entry) {
        if (!entry) return
        // Uses the actual DesktopEntry API to launch .desktop files.
        entry.execute()
        menu.closeRequested()
    }

    onVisibleChanged: {
        if (visible) {
            search.text = ""
            appList.currentIndex = 0
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
        border.width: 1
        border.color: Theme.blue
        radius: 1

        Rectangle { x: 0; y: 0; width: 4; height: parent.height; color: Theme.blue; opacity: .8 }
        Rectangle { x: 4; y: 0; width: 110; height: 2; color: Theme.blue }
        Rectangle { x: parent.width - 70; y: parent.height - 2; width: 70; height: 2; color: Theme.blue }

        Column {
            anchors.fill: parent
            anchors.leftMargin: 18
            anchors.rightMargin: 14
            anchors.topMargin: 12
            anchors.bottomMargin: 10
            spacing: 8

            Row {
                width: parent.width
                height: 42
                spacing: 9

                Rectangle {
                    width: 32; height: 32
                    border.color: Theme.blue
                    border.width: 1
                    color: Theme.surface
                    Text {
                        anchors.centerIn: parent
                        text: "D/"
                        color: Theme.blue
                        font.family: Theme.mono
                        font.bold: true
                        font.pixelSize: 13
                    }
                }

                Column {
                    spacing: 2
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        text: "APPLICATION INDEX"
                        font.family: Theme.mono
                        font.pixelSize: 14
                        font.bold: true
                        color: Theme.bone
                    }
                    Text {
                        text: "LOCAL CATALOG  /  DVR.03"
                        font.family: Theme.mono
                        font.pixelSize: 9
                        color: Theme.muted
                    }
                }

                Item { width: Math.max(0, parent.width - 320); height: 1 }

                Rectangle {
                    width: 71; height: 28
                    anchors.verticalCenter: parent.verticalCenter
                    color: closeArea.containsMouse ? Theme.raised : Theme.surface
                    border.color: Theme.subtle
                    Text {
                        anchors.centerIn: parent
                        text: "[ X ]"
                        color: Theme.blue
                        font.family: Theme.mono
                        font.pixelSize: 11
                    }
                    MouseArea {
                        id: closeArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: menu.closeRequested()
                    }
                }
            }

            Rectangle { width: parent.width; height: 1; color: Theme.subtle }

            Row {
                width: parent.width
                height: 17
                spacing: 8
                Text {
                    text: "SYS://APPLICATIONS"
                    color: Theme.blue
                    font.pixelSize: 10
                    font.family: Theme.mono
                }
                Text {
                    text: "// EXECUTION ACCESS"
                    color: Theme.muted
                    font.pixelSize: 10
                    font.family: Theme.mono
                }
            }

            Rectangle {
                width: parent.width
                height: 47
                color: Theme.surface
                border.width: 1
                border.color: search.activeFocus ? Theme.blue : Theme.subtle

                Rectangle {
                    x: 0; y: 0; width: 3; height: parent.height
                    color: Theme.blue
                }

                TextInput {
                    id: search
                    anchors.fill: parent
                    anchors.leftMargin: 14
                    anchors.rightMargin: 12
                    verticalAlignment: TextInput.AlignVCenter
                    clip: true
                    font.family: Theme.mono
                    font.pixelSize: 13
                    color: Theme.bone
                    focus: true
                    selectByMouse: true
                    onTextChanged: appList.currentIndex = 0

                    Keys.onEscapePressed: menu.closeRequested()
                    Keys.onDownPressed: {
                        appList.currentIndex = Math.min(appList.count - 1, Math.max(0, appList.currentIndex + 1))
                        appList.positionViewAtIndex(appList.currentIndex, ListView.Contain)
                    }
                    Keys.onUpPressed: {
                        appList.currentIndex = Math.max(0, appList.currentIndex - 1)
                        appList.positionViewAtIndex(appList.currentIndex, ListView.Contain)
                    }
                    onAccepted: menu.launch(filtered.values.length
                        ? filtered.values[Math.max(0, Math.min(filtered.values.length - 1, appList.currentIndex))]
                        : null)
                }
                Text {
                    anchors.fill: search
                    verticalAlignment: Text.AlignVCenter
                    text: "SEARCH APPLICATIONS_"
                    font.family: Theme.mono
                    font.pixelSize: 11
                    color: Theme.muted
                    visible: search.text.length === 0
                    enabled: false
                }
            }

            Row {
                width: parent.width
                height: 21
                spacing: 9
                Rectangle { width: 5; height: 5; color: Theme.blue; anchors.verticalCenter: parent.verticalCenter }
                Text {
                    text: filtered.values.length + " MATCHED / " + DesktopEntries.applications.values.length + " INDEXED"
                    font.family: Theme.mono
                    font.pixelSize: 10
                    color: Theme.blue
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            ListView {
                id: appList
                width: parent.width
                height: Math.max(40, parent.height - 202)
                model: filtered
                currentIndex: 0
                clip: true
                spacing: 3
                boundsBehavior: Flickable.StopAtBounds

                delegate: Rectangle {
                    id: entryRow
                    required property var modelData
                    required property int index
                    width: ListView.view.width
                    height: 49
                    radius: 1
                    color: hit.containsMouse || ListView.isCurrentItem ? Theme.raised : Theme.surface
                    border.width: 1
                    border.color: hit.containsMouse || ListView.isCurrentItem ? Theme.blue : Theme.subtle

                    Rectangle {
                        x: 0; y: 0; height: parent.height
                        width: ListView.isCurrentItem ? 3 : 1
                        color: Theme.blue
                        opacity: ListView.isCurrentItem ? 1 : .35
                    }
                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        spacing: 10
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: String(entryRow.index + 1).padStart(2, "0")
                            font.family: Theme.mono
                            font.pixelSize: 9
                            color: Theme.muted
                        }
                        IconImage {
                            width: 22; height: 22
                            anchors.verticalCenter: parent.verticalCenter
                            source: Quickshell.iconPath(entryRow.modelData.icon, true)
                        }
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: entryRow.modelData.name
                            width: Math.max(0, entryRow.width - 110)
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
                        onClicked: {
                            appList.currentIndex = entryRow.index
                            menu.launch(entryRow.modelData)
                        }
                    }
                }
            }

            Rectangle { width: parent.width; height: 1; color: Theme.subtle }
            Row {
                width: parent.width
                spacing: 8
                Text {
                    text: "↑↓ SELECT  /  ENTER EXECUTE  /  ESC CLOSE"
                    font.family: Theme.mono
                    font.pixelSize: 9
                    color: Theme.muted
                }
            }
        }
    }
}
