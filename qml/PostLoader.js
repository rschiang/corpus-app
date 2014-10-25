WorkerScript.onMessage = function(params) {
    var entries = JSON.parse(params.src)
    var posts = {}

    params.model.clear()
    for (var i in entries) {
        var entry = entries[i]
        posts[entry.postId] = entry
        params.model.append({ postId: entry.postId })
    }

    WorkerScript.sendMessage({ posts: posts })
    params.model.sync()
    WorkerScript.sendMessage({ done: true })
}
