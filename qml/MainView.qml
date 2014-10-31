import QtQuick 2.0
import "material"
import "Cache.js" as Cache

Item {
    id: view
    anchors.fill: parent
    state: "visible"

    property bool loading: false

    ActionBar {
        id: actionBar
        raised: posts.contentY > height
        color: "#00796b"
        text: "Corpus"
        z: 2

        MouseArea {
            anchors.fill: parent
            onDoubleClicked: scrollToTopAnimation.start()
        }

        IconButton {
            id: menuButton
            anchors.left: parent.left
            anchors.leftMargin: 16 * dp
            anchors.verticalCenter: parent.verticalCenter

            iconSource: "qrc:/assets/icon_menu"
            onClicked: menu.open()
        }

        RefreshButton {
            id: refreshButton
            anchors.right: parent.right
            anchors.rightMargin: 16 * dp
            anchors.verticalCenter: parent.verticalCenter

            loading: view.loading
            onClicked: load()
        }
    }

    ListView {
        id: posts
        anchors.fill: parent
        anchors.topMargin: actionBar.height
        cacheBuffer: root.height * 4

        topMargin: 8 * dp
        bottomMargin: 8 * dp
        leftMargin: 8 * dp
        rightMargin: 8 * dp
        spacing: 8 * dp

        interactive: !postView.visible

        model: ListModel {}

        delegate: Component {
            Card {
                id: __postCard
                width: parent.width - 16 * dp
                height: __postCardLayout.height

                PostCardLayout {
                    id: __postCardLayout
                    postId: model.postId
                }

                onClicked: {
                    postView.postId = model.postId
                    postView.cardY = __postCard.y - posts.contentY
                    postView.show()
                }
            }
        }

        NumberAnimation on contentY {
            id: scrollToTopAnimation
            to: -posts.topMargin
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
        transform: Translate {
            y: postView.visible ? 72 * dp : 0

            Behavior on y {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                }
            }
        }

        color: "#795548"
        iconSource: "qrc:/assets/icon_add"

        onClicked: postDialog.open()
    }

    states: [
        State {
            name: "hidden"
            PropertyChanges { target: posts; opacity: 0 }
        },
        State {
            name: "visible"
            PropertyChanges { target: posts; opacity: 1 }
        }
    ]

    transitions: [
        Transition {
            SequentialAnimation {
                PauseAnimation { duration: 200 }
                NumberAnimation {
                    target: posts
                    property: "opacity"
                    duration: 280
                    easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                }
            }
        }
    ]

    WorkerScript {
        id: loader
        source: "PostLoader.js"
        onMessage: {
            if (messageObject.done) {
                view.loading = false
            }
            else if (messageObject.posts) {
                Cache.posts = messageObject.posts
            }
        }
    }

    function load() {
        view.loading = true
        api.posts(function(e) {
            loader.sendMessage({ src: e, model: posts.model })
        })
    }

    Component.onCompleted: load()
}
