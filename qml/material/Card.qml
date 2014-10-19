import QtQuick 2.0

Item {
    id: root

    Rectangle {
        id: background
        anchors.fill: parent
        color: "white"
        radius: 2
        visible: false
    }

    PaperShadow {
        id: shadow
        source: background
        depth: root.enabled ? (mouseArea.pressed ? 2 : 1) : 0
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: root.enabled
    }
}
