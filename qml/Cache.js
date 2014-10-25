.pragma library

var posts = {}

function setPost(id, value) {
    posts[id] = value
}

function getPost(id) {
    return posts[id]
}

function containsPost(id) {
    return (id in posts)
}
