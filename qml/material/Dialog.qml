import QtQuick 2.0
import "."

Popup {
    id: popup

    property alias dialogWidth: dialog.width
    property alias dialogHeight: dialog.height
    default property alias dialogChildren: layout.children

    Item {
        id: dialog
        anchors.centerIn: parent
        implicitWidth: Math.min(layout.implicitWidth, parent.width - 80 * dp)
        implicitHeight: layout.height

        PaperShadow {
            id: shadow
            anchors.fill: background
            source: background
            depth: 5
        }

        Rectangle {
            id: background
            anchors.fill: parent
            color: "#fafafa"
            visible: false
        }

        Column {
            id: layout
        }
    }
}
