import QtQuick 2.0

Item {
    id: root
    width: (inline || label.paintedWidth > 56 * dp) ? (label.paintedWidth + 32 * dp) : (88 * dp)
    height: 36 * dp

    property bool inline: false
    property alias text: label.text
    property alias textColor: label.color

    signal clicked

    Rectangle {
        id: background
        anchors.fill: parent
        radius: 3 * dp
        color: root.enabled ? "#00999999" : "#1a999999"
        visible: false
    }

    Text {
        id: label
        anchors.centerIn: parent
        font.family: platformFont
        font.pointSize: 14
        font.bold: Font.DemiBold
        font.capitalization: Font.AllUppercase
        color: "#de000000"
    }

    PaperRipple {
        id: ripple
        radius: 3 * dp
        mouseArea: mouseArea
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: root.enabled
        onClicked: root.clicked()
    }
}
