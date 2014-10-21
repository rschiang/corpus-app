import QtQuick 2.0
import "material"

Item {
    id: card
    implicitWidth: parent.width
    implicitHeight: layout.height

    property variant post: ({})

    Column {
        id: layout
        width: parent.width

        Rectangle {
            width: parent.width
            height: image.height
            color: "#1a999999"
            visible: (height > 0)

            Image {
                id: image
                width: parent.width
                height: post.photos ? parent.width * 0.6 : 0
                sourceSize.width: screenMaxWidth
                sourceSize.height: screenMaxWidth
                fillMode: Image.PreserveAspectCrop
                clip: true

                asynchronous: true
                source: post.photos ? api.photo(post.photos) : ""
            }
        }

        Item {
            width: parent.width
            height: article.paintedHeight + 32 * dp

            Text {
                id: article
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    margins: 16 * dp
                }

                font.family: "Roboto Slab"
                font.pointSize: text.length <= 16 ? 20 : 16
                color: "#de000000"
                wrapMode: Text.Wrap

                text: post.description || ""
            }
        }

        Item {
            width: parent.width
            height: 56 * dp

            FlatButton {
                id: likeButton
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    margins: 8 * dp
                }

                inline: true
                text: post.starredNum > 0 ? ("+" + post.starredNum) : "+1"
                textColor: post.starred ? "#5d4037" : "#de000000"
            }

            FlatButton {
                id: commentButton
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: likeButton.right
                    margins: 8 * dp
                }

                inline: true
                text: post.commentNum > 0 ? ("留言(%d)".replace("%d", post.commentNum)) : "留言"
            }

            Text {
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    margins: 16 * dp
                }
                font.family: platformFont
                font.pointSize: 14
                color: "#8a000000"
                text: post.textTime ? formatTime() : ""
            }
        }
    }

    function formatTime() {
        var formats = {"_Second_": "%d 秒前", "_Minute_": "%d 分鐘前", "_Hour_": "%d 小時前", "_Yesterday_": "昨天"}
        if (post.textTime.unit in formats)
            return formats[post.textTime.unit].replace("%d", post.textTime.num)
        else
            return post.textTime.num
    }
}
