import QtQuick 2.0

Item {
    id: root
    width: 56 * dp
    height: 56 * dp

    property alias color: background.color

    signal clicked

    Rectangle {
        id: background
        anchors.fill: parent
        radius: 28 * dp
        visible: false
    }

    PaperShadow {
        id: shadow
        source: background
        depth: root.enabled ? (mouseArea.pressed ? 5 : 3) : 0
    }

    PaperRipple {
        id: ripple
        radius: 2 * dp
        color: "#deffffff"
        mouseArea: mouseArea
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: root.enabled
    }
}
