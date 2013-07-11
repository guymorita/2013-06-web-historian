url = require('url')
fs = require('fs')

exports.datadir = __dirname + "data/sites.txt" # tests will need to override this.
defaultCorsHeaders = {
  "access-control-allow-origin": "*",
  "access-control-allow-methods": "GET, POST, PUT, DELETE, OPTIONS",
  "access-control-allow-headers": "content-type, accept",
  "access-control-max-age": 10 # Seconds.
}
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
    headers = defaultCorsHeaders
    if (req.url is "/" || req.url is "/index.html")
      console.log('index.html requested/sent');
      headers['Content-Type'] = "text/html";
      res.writeHead(200, headers);
      indexHtml = fs.readFileSync('../../public/index.html');
      res.end(indexHtml);
    else if (req.url is "/js/controllers.js")
      console.log('controllers.js requested/sent');
      headers['Content-Type'] = "application/javascript";
      res.writeHead(200, headers);
      controllerjs = fs.readFileSync('../../public/js/controllers.js');
      res.end(controllerjs);
    else if (req.url is "/styles.css")
      console.log('styles.css requested/sent');
      headers['Content-Type'] = "text/css";
      res.writeHead(200, headers);
      stylecss = fs.readFileSync('../../public/styles.css');
      res.end(stylecss);
    else if (req.url is "/data/sites.json")
      console.log('sites.json requested/sent');
      headers['Content-Type'] = "application/json";
      res.writeHead(200, headers);
      sitesjson = fs.readFileSync('../../../data/sites.json');
      res.end(sitesjson);
    else
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