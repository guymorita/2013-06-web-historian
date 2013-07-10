_ = require 'lodash'
fs = require 'fs'
http = require 'http-get'
moment = require 'moment'

exports.readUrls = (filePath, cb) ->
  urls = fs.readFileSync(filePath, 'utf8')
  newURLArray = urls.split("\n")
  newURLArray.pop() # remove blank line ending file
  cb(newURLArray)

exports.downloadUrls = (urls) ->
  _.each urls, (value) ->
    if not fs.stat("../../../data/sites/#{value}")
      fs.mkdir("../../../data/sites/#{value}")
    path = "../../../data/sites/#{value}/#{moment().format('YY-MM-DD--hh-mm-ss')}.html"
    # path = "../../../data/sites/index.html"
    console.log 'value', value, 'path', path
    http.get value, path, (err, result) ->
      if err then console.log err
      else console.log result.file
