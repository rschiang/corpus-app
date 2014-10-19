import QtQuick 2.0

Item {
    id: root
    width: Math.max(88 * dp, label.paintedWidth + 32 * dp)
    height: 36 * dp

    property alias text: label.text

    signal clicked

    Rectangle {
        id: background
        anchors.fill: parent
        radius: 2 * dp
        color: root.enabled ? "white" : "#eaeaea"
        visible: false
    }

    PaperShadow {
        id: shadow
        source: background
        depth: root.enabled ? (mouseArea.pressed ? 3 : 1) : 0
    }

    PaperRipple {
        id: ripple
        radius: 2 * dp
        mouseArea: mouseArea
    }

    Text {
        id: label
        anchors.centerIn: parent
        font.family: platformFont
        font.pointSize: 14 * dp
        font.bold: Font.DemiBold
        font.capitalization: Font.AllUppercase
        color: "#de000000"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: root.enabled
    }
}
