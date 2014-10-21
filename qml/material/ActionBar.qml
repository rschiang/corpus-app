import QtQuick 2.0

Item {
    id: root
    width: parent.width
    height: 56 * dp

    property alias color: background.color
    property alias text: title.text
    property bool raised: false

    PaperShadow {
        source: background
        depth: root.raised ? 2 : 1
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "white"
    }

    Text {
        id: title
        x: 72 * dp
        anchors.verticalCenter: parent.verticalCenter
        font.family: platformFont
        font.bold: Font.DemiBold
        font.pointSize: 20
        color: "white"
    }
}
