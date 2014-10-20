import QtQuick 2.0
import "material"

Item {
    id: view
    anchors.fill: parent

    ListView {
        id: posts
        anchors.fill: parent
        cacheBuffer: height

        model: ListModel {}

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
    }

    FloatingActionButton {
        id: addButton
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: 16 * dp
        }

        color: "#795548"
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
