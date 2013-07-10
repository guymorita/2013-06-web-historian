url = require('url')
fs = require('fs')

exports.datadir = __dirname + "data/sites.txt" # tests will need to override this.

exports.handleRequest = (req, res) ->
  console.log 'req method is', req.method, req.headers
  if req.method is 'POST'
    data = ''
    req.on 'data', (dataChunk) ->
      data += dataChunk
    req.on 'end', ->
      data = data.match(/url=(www\.\w+\.\w{1,4})/)[1]
      fs.writeFileSync(exports.datadir, data+"\n")
      res.writeHead(302)
      res.end()
      # console.log 'data is ', data

  else if req.method is 'GET'
    parsedURL = url.parse(req.url)
    console.log(parsedURL)
    console.log("Requested path is #{parsedURL.path}")
    console.log("Data Directory #{exports.datadir}")
    if parsedURL.path.match(/^\/$|^\/(www\.\w+\.\w{1,4})$/)
      res.writeHead(200)
      res.end("<input> #{parsedURL.path}")
    else
      res.writeHead(404)
      res.end()
