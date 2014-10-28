import QtQuick 2.0
import "material"
import "Cache.js" as Cache

Item {
    id: card
    implicitWidth: parent.width
    implicitHeight: layout.height

    property string postId

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
                height: source != "" ? parent.width * 0.6 : 0
                sourceSize.width: root.width
                sourceSize.height: root.width
                fillMode: Image.PreserveAspectCrop
                clip: true
                asynchronous: true
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

                font.family: UIConstants.serifFontFamily
                font.pointSize: text.length <= 16 ? UIConstants.titleFontSize : UIConstants.subheadFontSize
                color: UIConstants.bodyTextColor
                wrapMode: Text.Wrap
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
                text: "+1"
                textColor: "#de000000"
                onClicked: {
                    var post = Cache.getPost(postId)
                    post.starred = !post.starred
                    post.starredNum = parseInt(post.starredNum) + (post.starred ? 1 : -1)
                    card.reload()

                    api.star(post.postId, function(e) {})
                }
            }

            Item {
                id: comments
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: likeButton.right
                    margins: 8 * dp
                }
                width: 70 * dp
                height: 36 * dp

                Image {
                    anchors {
                        right: commentsLabel.left
                        rightMargin: 3 * dp
                        verticalCenter: parent.verticalCenter
                    }
                    width: 24 * dp
                    height: 24 * dp
                    sourceSize.width: width
                    sourceSize.height: height
                    source: "qrc:/assets/icon_comment"
                }

                Text {
                    id: commentsLabel
                    anchors {
                        centerIn: parent
                        horizontalCenterOffset: -15 * dp
                    }
                    font.family: UIConstants.sansFontFamily
                    font.pointSize: UIConstants.bodyFontSize
                    font.bold: Font.DemiBold
                    font.capitalization: Font.AllUppercase
                    color: UIConstants.bodyTextColor
                }
            }

            Text {
                id: timestamp
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    margins: 16 * dp
                }
                font.family: UIConstants.sansFontFamily
                font.pointSize: UIConstants.bodyFontSize
                color: "#8a000000"
                text: ""
            }
        }
    }

    function reload() {
        if (!Cache.containsPost(postId))
            return

        var post = Cache.getPost(postId)
        image.source = post.photos ? api.photo(post.photos) : ""
        article.text = post.description ? post.description.trim() : ""
        likeButton.text = post.starredNum > 0 ? ("+" + post.starredNum) : "+1"
        likeButton.textColor = post.starred ? "#8d6e63" : "#de000000"
        comments.opacity = post.commentNum > 0 ? 1 : 0.62
        commentsLabel.text = post.commentNum > 0 ? post.commentNum : ""

        if (post.textTime) {
            var formats = {"_Second_": "%d 秒前", "_Minute_": "%d 分鐘前", "_Hour_": "%d 小時前", "_Yesterday_": "昨天"}
            if (post.textTime.unit in formats)
                timestamp.text = formats[post.textTime.unit].replace("%d", post.textTime.num)
            else
                timestamp.text = post.textTime.num
        } else {
            timestamp.text = ""
        }
    }

    onPostIdChanged: reload()
}
