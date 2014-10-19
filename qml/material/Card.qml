import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    property int radius: 2
    property color color: "#de000000"

    Rectangle {
        id: background
        anchors.fill: parent
        color: root.enabled ? "white" : "#eaeaea"
        radius: root.radius
        visible: false
    }

    PaperShadow {
        id: shadow
        source: background
        depth: root.enabled ? (mouseArea.pressed ? 2 : 1) : 0
    }

    PaperRipple {
        id: ripple
        radius: root.radius
        mouseArea: mouseArea
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: root.enabled
    }
}
