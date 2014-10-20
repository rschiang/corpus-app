import QtQuick 2.0
import "material"

Card {
    id: card
    width: parent.width
    height: image.height + content.height + 32 * dp

    property variant post: ({})

    Image {
        id: image
        width: parent.width
        height: status == Image.Ready ? parent.width * 0.67 : 0
        asynchronous: true
        fillMode: Image.PreserveAspectCrop
        clip: true

        source: post.photos ? api.photo(post.photos) : ""
    }

    Column {
        id: content
        anchors {
            left: parent.left
            right: parent.right
            top: image.bottom
            margins: 16 * dp
        }
        spacing: 8 * dp

        Text {
            font.family: platformFont
            font.pointSize: 14
            color: "#8a000000"
            text: post.textTime ? ["%s", "%ss", "%sm", "%sh", "昨天"][
                                  ["_Second_", "_Minute_", "_Hour_", "_Yesterday_"]
                                  .indexOf(post.textTime.unit) + 1]
                                  .replace("%s", post.textTime.num)
                                  .trim()
                                : ""
        }

        Text {
            width: parent.width
            font.family: platformFont
            font.pointSize: text.length <= 16 ? 16 : 14
            color: "#de000000"
            wrapMode: Text.Wrap

            text: post.description || ""
        }

        Row {
            spacing: 8 * dp
            anchors.margins: -16 * dp

            FlatButton {
                id: likeButton
                inline: true
                text: post.starredNum > 0 ? ("+" + post.starredNum) : "+1"
                textColor: post.starred ? "#5d4037" : "#de000000"
            }

            FlatButton {
                id: commentButton
                inline: true
                text: post.commentNum > 0 ? ("留言(%d)".replace("%d", post.commentNum)) : "留言"
            }
        }
    }
}
