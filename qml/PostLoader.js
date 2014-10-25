WorkerScript.onMessage = function(params) {
    var e = JSON.parse(params.src)
    params.model.clear()
    for (var i in e)
        params.model.append(e[i])
    WorkerScript.sendMessage({ done: true })
    params.model.sync()
}
