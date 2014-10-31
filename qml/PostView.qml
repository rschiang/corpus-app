import QtQuick 2.0
import "material"

Item {
    id: view
    anchors.fill: parent
    state: "hidden"
    opacity: 0
    visible: false

    property string postId
    property int cardY: 0
    property bool loading: false

    MouseArea {
        id: eventEater
        anchors.fill: parent
        enabled: (view.state == "visible")
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
        interactive: view.visible

        transform: Translate { id: contentTransform }

        Card {
            id: card
            width: parent.width
            height: layout.height + column.height
            raised: true

            PostCardLayout {
                id: layout
                postId: view.postId
            }

            Column {
                id: column
                anchors {
                    left: parent.left
                    right: parent.right
                    top: layout.bottom
                    leftMargin: 16 * dp
                    rightMargin: 16 * dp
                }
                height: (comments.count > 0) ? (implicitHeight + 16 * dp) : 0
                spacing: 16 * dp

                Repeater {
                    id: comments
                    model: ListModel {}
                    delegate: Component {
                        Text {
                            id: __text
                            width: column.width
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

                add: Transition {
                    NumberAnimation {
                        property: "opacity"
                        from: 0; to: 1
                        duration: 200
                        easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                    }
                }
            }

            Behavior on height {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                }
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
        color: "white"

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
                api.comment(view.postId, field.text, function(e) {
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
            PropertyChanges { target: view; focus: false }
        },
        State {
            name: "visible"
            PropertyChanges { target: view; focus: true }
        }
    ]

    transitions: [
        Transition {
            to: "hidden"
            SequentialAnimation {
                ParallelAnimation {
                    ScriptAction {
                        script: comments.model.clear()
                    }
                    NumberAnimation {
                        target: contentTransform
                        property: "y"
                        duration: 280
                        from: 0; to: (cardY + contents.contentY)
                        easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                    }
                }
                NumberAnimation {
                    target: view
                    property: "opacity"
                    to: 0
                    duration: 200
                    easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                }
                ScriptAction {
                    script: {
                        view.visible = false
                        view.postId = ""
                    }
                }
            }
        },
        Transition {
            to: "visible"
            NumberAnimation {
                target: view
                property: "opacity"
                to: 1
                duration: 200
                easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
            }
            NumberAnimation {
                target: contentTransform
                property: "y"
                duration: 280
                from: (cardY - contents.topMargin)
                to: 0
                easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
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
        })
    }

    function show() {
        view.visible = true
        state = "visible"
        mainView.state = "hidden"
    }

    function hide() {
        state = "hidden"
        mainView.state = "visible"
    }
}
