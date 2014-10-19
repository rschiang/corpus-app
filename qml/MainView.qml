import QtQuick 2.0
import "material"

Item {
    id: view
    anchors.fill: parent

    ListView {
        id: posts
        anchors.fill: parent

        delegate: Component {
            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                height: 8 * dp + __postCard.height

                PostCard {
                    id: __postCard
                    post: model
                    y: 8 * dp
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: 8 * dp
                    }
                }
            }
        }

        populate: Transition {
            NumberAnimation {
                properties: "x"
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
    }

    FloatingActionButton {
        id: addButton
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: 16 * dp
        }

        color: "#5677fc"
        iconSource: "qrc:/assets/icon_add"
    }
}
