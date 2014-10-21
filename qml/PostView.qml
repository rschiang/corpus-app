import QtQuick 2.0
import "material"

Item {
    id: view
    anchors.fill: parent
    state: "hidden"
    opacity: 0
    visible: false

    property string postId: ""
    property alias post: layout.post

    ActionBar {
        id: actionBar
        raised: contents.contentY > height
        color: "#00796b"
        text: "Corpus"
        z: 2

        IconButton {
            id: backButton
            anchors.left: parent.left
            anchors.leftMargin: 16 * dp
            anchors.verticalCenter: parent.verticalCenter

            iconSource: "qrc:/assets/icon_back"
            onClicked: view.hide()
        }
    }

    Rectangle {
        id: background
        anchors.fill: contents
        color: "#eee"
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
        leftMargin: 8 * dp
        rightMargin: 8 * dp

        contentWidth: width - 16 * dp
        contentHeight: card.height

        Card {
            id: card
            width: parent.width
            height: column.height

            Column {
                id: column
                width: parent.width

                PostCardLayout {
                    id: layout
                }

                Repeater {
                    id: comments
                    model: ListModel {}
                    delegate: Component {
                        Item {
                            x: 16 * dp
                            width: (parent ? parent.width - 32 * dp : 0)
                            height: __text.paintedHeight + 16 * dp

                            Text {
                                id: __text
                                y: 8 * dp
                                width: parent.width
                                wrapMode: Text.Wrap
                                font.family: platformFont
                                font.pointSize: 14
                                color: "#de000000"
                                text: model.content ?
                                      "<font color='#00796b'><b>" + model.username + "</b>: </font>" + model.content :
                                      ""
                            }
                        }
                    }
                }
            }
        }
    }

    states: [
        State {
            name: "hidden"
            PropertyChanges { target: view; opacity: 0 }
        },
        State {
            name: ""
            PropertyChanges { target: view; opacity: 1 }
        }
    ]

    transitions: [
        Transition {
            SequentialAnimation {
                ScriptAction {
                    script: if (state != "hidden") view.visible = true
                }
                NumberAnimation {
                    target: view
                    properties: "opacity"
                    duration: 280
                    easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                }
                ScriptAction {
                    script: if (state == "hidden") {
                                view.visible = false
                                view.post = {}
                                comments.model.clear()
                            }
                }
            }
        }
    ]

    onPostIdChanged: {
        api.comments(postId, function(e) {
            e = JSON.parse(e)
            comments.model.clear()
            for (var i in e)
                comments.model.append(e[i])
        })
    }

    function show() {
        state = ""
    }

    function hide() {
        state = "hidden"
    }
}
