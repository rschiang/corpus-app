import QtQuick 2.0
import "material"

Item {
    id: root
    width: parent.width
    height: 56 * dp

    property bool raised: false

    PaperShadow {
        source: background
        depth: root.raised ? 2 : 1
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#00796b"
    }

    Image {
        source: "qrc:/assets/icon_menu"
        width: 24 * dp
        height: 24 * dp
        x: 16 * dp
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: title
        x: 72 * dp
        anchors.verticalCenter: parent.verticalCenter
        font.family: platformFont
        font.bold: Font.DemiBold
        font.pointSize: 20
        color: "white"
        text: "Corpus"
    }
}
