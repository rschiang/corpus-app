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
    property int cardY: 0
    property bool loading: false

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#eee"
        opacity: 0
    }

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

        RefreshButton {
            id: refreshButton
            anchors.right: parent.right
            anchors.rightMargin: 16 * dp
            anchors.verticalCenter: parent.verticalCenter

            loading: view.loading
            onClicked: load()
        }
    }

    Flickable {
        id: contents
        anchors {
            top: actionBar.bottom
            left: parent.left
            right: parent.right
            bottom: footer.top
        }

        topMargin: 8 * dp
        bottomMargin: 8 * dp
        leftMargin: 8 * dp
        rightMargin: 8 * dp

        contentWidth: width - 16 * dp
        contentHeight: card.height
        flickableDirection: Flickable.VerticalFlick
        interactive: visible

        Card {
            id: card
            width: parent.width
            height: column.height
            raised: true

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
                                width: parent.width
                                wrapMode: Text.Wrap
                                font.family: UIConstants.sansFontFamily
                                font.pointSize: UIConstants.bodyFontSize
                                color: "#de000000"
                                text: model.content ?
                                      "<font color='#00796b'><b>" + model.username + "</b>: </font>" + model.content :
                                      ""
                            }
                        }
                    }

                }
            }

            Behavior on height {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                }
            }

            NumberAnimation {
                id: loadedAnimation
                target: column
                property: "opacity"
                from: 0; to: 1
                duration: 200
                easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
            }
        }
    }

    Rectangle {
        id: footer
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: field.height
        color: "#fafafa"

        TextField {
            id: field
            anchors {
                left: parent.left
                right: sendButton.left
                margins: 16 * dp
            }
            focusColor: "#795548"
            hint: "留言⋯⋯"

            Keys.onReturnPressed: {
                if (length > 0) sendButton.clicked()
            }
        }

        IconButton {
            id: sendButton
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                margins: 16 * dp
            }
            iconSource: "qrc:/assets/icon_send-colored"

            enabled: (field.length > 0)
            onClicked: {
                api.comment(postId, field.text, function(e) {
                    e = JSON.parse(e)
                    comments.model.append(e)
                })
                field.text = ""
            }
        }
    }

    states: [
        State {
            name: "hidden"
        },
        State {
            name: ""
        }
    ]

    transitions: [
        Transition {
            to: "hidden"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation {
                        target: contents
                        property: "contentY"
                        duration: 280
                        to: -cardY
                        easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                    }
                    NumberAnimation {
                        target: background
                        property: "opacity"
                        to: 0
                        duration: 280
                        easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                    }
                }
                NumberAnimation {
                    targets: [view, contents]
                    property: "opacity"
                    to: 0
                    duration: 280
                    easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                }
                ScriptAction {
                    script: {
                        view.focus = false
                        view.visible = false
                        view.post = {}
                        view.postId = ""
                        comments.model.clear()
                    }
                }
            }
        },
        Transition {
            to: ""
            SequentialAnimation {
                ScriptAction {
                    script: {
                        contents.opacity = 0
                        view.visible = true
                        view.focus = true
                    }
                }
                NumberAnimation {
                    target: view
                    property: "opacity"
                    to: 1
                    duration: 280
                    easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                }
                ParallelAnimation {
                    NumberAnimation {
                        target: contents
                        property: "contentY"
                        duration: 280
                        from: -cardY
                        to: -contents.topMargin
                        easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                    }
                    NumberAnimation {
                        targets: [background, contents]
                        property: "opacity"
                        to: 1
                        duration: 280
                        easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                    }
                }
            }
        }
    ]

    onPostIdChanged: {
        if (postId) load()
    }

    Keys.onReleased: {
        if (event.key == Qt.Key_Back) {
            event.accepted = true
            hide()
        }
    }

    function load() {
        view.loading = true
        api.comments(postId, function(e) {
            e = JSON.parse(e)
            comments.model.clear()
            for (var i in e)
                comments.model.append(e[i])
            view.loading = false
            loadedAnimation.start()
        })
    }

    function show() {
        state = ""
    }

    function hide() {
        state = "hidden"
    }
}
