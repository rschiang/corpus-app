import QtQuick 2.0
import "material"

Item {
    id: actionBar
    width: parent.width
    height: 56 * dp

    PaperShadow {
        source: background
        depth: 1
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
        font.pointSize: 20
        color: "white"
        text: "Corpus"
    }
}
