import QtQuick 2.0
import "material"

Item {
    id: view
    anchors.fill: parent

    Column {
        spacing: 8 * dp
        anchors {
            fill: parent
            leftMargin: 8 * dp
            rightMargin: 8 * dp
            topMargin: 8 * dp
        }

        Card {
            anchors {
                left: parent.left
                right: parent.right
            }
            height: contentText.height + 32 * dp

            Text {
                id: contentText
                font.family: platformFont
                font.pointSize: 14 * dp
                x: 16 * dp
                y: 16 * dp
                width: parent.width - 32 * dp
                wrapMode: Text.Wrap
                text: "Lorem ipsum\ndolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
            }
        }

        Row {
            spacing: 8 * dp

            RaisedButton {
                text: "Decline"
            }

            RaisedButton {
                text: "Accept"
            }
        }
    }

    FloatingActionButton {
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: 16 * dp
        }

        color: "#259b24"
    }
}
