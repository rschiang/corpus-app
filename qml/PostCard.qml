import QtQuick 2.0
import "material"

Card {
    id: card
    width: parent.width
    height: image.height + label.paintedHeight + 32 * dp

    property variant post: ({})

    Image {
        id: image
        width: parent.width
        height: status == Image.Ready ? parent.width * 0.75 : 0
        asynchronous: true
        fillMode: Image.PreserveAspectCrop
        clip: true

        source: post.photos || ""
    }

    Text {
        id: label
        anchors {
            left: parent.left
            right: parent.right
            top: image.bottom
            margins: 16 * dp
        }

        font.family: platformFont
        font.pointSize: 14 * dp
        color: "#de000000"
        wrapMode: Text.Wrap

        text: post.description || ""
    }
}
