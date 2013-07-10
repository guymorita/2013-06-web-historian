http = require "http"
myStuff = require "./request-handler.js"

port = 8081
ip = "127.0.0.1"
server = http.createServer(myStuff.handleRequest)
console.log("Listening on http://" + ip + ":" + port)
server.listen(port, ip)
