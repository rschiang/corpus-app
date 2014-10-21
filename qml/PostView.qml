import QtQuick 2.0
import "material"

Item {
    id: view
    anchors.fill: parent
    state: "hidden"

    property string postId: ""

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

        contentWidth: width
        contentHeight: card.height

        Card {
            id: card
            anchors {
                left: parent.left
                right: parent.right
                margins: 8 * dp
            }
            height: column.height

            Column {
                id: column
                width: parent.width

                PostCardLayout {
                    id: layout
                }
            }

            Repeater {
                id: comments
                model: ListModel {}
                delegate: Component {
                    Item {
                        anchors {
                            left: parent.left
                            right: parent.right
                            margins: 16 * dp
                        }
                        height: __text.paintedHeight + 16 * dp

                        Text {
                            id: __text
                            y: 8 * dp
                            width: parent.width
                            wrapMode: Text.Wrap
                            font.family: platformFont
                            font.pointSize: 14
                            color: "#de000000"
                            text: modelData.content ?
                                  "<font color='#00796b'><b>" + modelData.username + "</b>: </font>" + modelData.content :
                                  ""
                        }
                    }
                }
            }
        }
    }

    onPostIdChanged: {
        Api.comments(postId, function(e) {
            e = JSON.parse(e)
            comments.model.clear()
            for (var i in e)
                comments.model.append(e[i])
        })
    }
}
