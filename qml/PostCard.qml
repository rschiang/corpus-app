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
        height: status == Image.Ready ? parent.width * 0.75 : 0
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
            width: parent.width
            font.family: platformFont
            font.pointSize: 14
            font.bold: Font.DemiBold
            color: "#de000000"
            wrapMode: Text.Wrap

            text: ((post.textTime ?
                   (post.textTime.num +
                    (["", " mins", " hours"])[["_Minute_", "_Hour_"]
                                              .indexOf(post.textTime.unit) + 1] + " ") : "") +
                  (post.commentNum > 0 ? "+" + post.commentNum : "")).trim()
        }

        Text {
            width: parent.width
            font.family: platformFont
            font.pointSize: 14
            color: "#de000000"
            wrapMode: Text.Wrap

            text: post.description || ""
        }
    }
}
