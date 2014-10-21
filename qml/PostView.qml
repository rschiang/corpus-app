import QtQuick 2.0
import "material"

Item {
    id: view
    anchors.fill: parent
    state: "hidden"

    ActionBar {
        id: actionBar
        raised: posts.contentY > height
        color: "#00796b"
        text: "Corpus"
        z: 2

        IconButton {
            id: backButton
            anchors.left: parent.left
            anchors.leftMargin: 16 * dp
            anchors.verticalCenter: parent.verticalCenter

            iconSource: "qrc:/assets/icon_back"
        }
    }

    Flickable {
        id: contents
        anchors {
            top: actionBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        topMargin: 8 * dp
        bottomMargin: 8 * dp
    }
}
