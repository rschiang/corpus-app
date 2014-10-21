import QtQuick 2.0
import "material"

Item {
    id: view
    anchors.fill: parent

    property bool loading: false

    ActionBar {
        id: actionBar
        raised: posts.contentY > height
        color: "#00796b"
        text: "Corpus"
        z: 2

        MouseArea {
            anchors.fill: parent
            onClicked: scrollToTopAnimation.start()
        }

        IconButton {
            id: menuButton
            anchors.left: parent.left
            anchors.leftMargin: 16 * dp
            anchors.verticalCenter: parent.verticalCenter

            iconSource: "qrc:/assets/icon_menu"
        }

        IconButton {
            id: refreshButton
            anchors.right: parent.right
            anchors.rightMargin: 16 * dp
            anchors.verticalCenter: parent.verticalCenter

            iconSource: "qrc:/assets/icon_refresh"
            onClicked: load()

            SequentialAnimation {
                running: view.loading
                loops: Animation.Infinite

                NumberAnimation { target: refreshButton; property: "rotation"; from: 360; to: 180; duration: 200; easing.type: Easing.OutQuad }
                NumberAnimation { target: refreshButton; property: "rotation"; from: 180; to: 0; duration: 200; easing.type: Easing.InQuad }

                onStopped: refreshButton.rotation = 0
            }
        }
    }

    ListView {
        id: posts
        anchors.fill: parent
        anchors.topMargin: actionBar.height
        cacheBuffer: height * 4

        topMargin: 8 * dp
        bottomMargin: 8 * dp
        spacing: 8 * dp

        model: ListModel {}

        delegate: Component {
            PostCard {
                id: __postCard
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: 8 * dp
                }
                post: model
            }
        }

        NumberAnimation on contentY {
            id: scrollToTopAnimation
            to: posts.originY
            duration: 300
            easing.type: Easing.OutCubic
            onStopped: posts.returnToBounds()
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
        iconSource: "qrc:/assets/icon_add"
    }

    function load() {
        view.loading = true
        api.posts(function(e) {
            e = JSON.parse(e)
            posts.model.clear()
            for (var i in e)
                posts.model.append(e[i])
            view.loading = false
        })
    }

    Component.onCompleted: load()
}
