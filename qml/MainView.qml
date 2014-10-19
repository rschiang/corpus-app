import QtQuick 2.0
import "material"

Item {
    id: view
    anchors.fill: parent

    ListView {
        id: posts
        anchors.fill: parent

        model: ListModel {}

        header: Component {
            Item {
                id: actionBar
                width: parent.width
                height: 56 * dp

                Text {
                    id: title
                    x: 72 * dp
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: platformFont
                    font.pointSize: 20
                    font.bold: Font.DemiBold
                    color: "#de000000"
                    text: "Corpus"
                }
            }
        }

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

        add: Transition {
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
        iconSource: "qrc:/assets/icon_refresh"

        onClicked: load()
    }

    function load() {
        api.posts(function(e) {
            e = JSON.parse(e)
            posts.model.clear()
            for (var i in e)
                posts.model.append(e[i])
        })
    }

    Component.onCompleted: load()
}
