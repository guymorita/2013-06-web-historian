_ = require 'lodash'
fs = require 'fs'
http = require 'http-get'
# http = require 'http'
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
    console.log 'value', value, 'path', path
    http.get value, path, (err, result) ->
      if err then console.log err
      else console.log result.file

    # could be written with 'http' module also as shown below
    # options = {
    #     host: value
    #     port: 80
    # }
    # file = ''
    # http.get options, (res) ->
    #   res.on 'data', (data) ->
    #     file += data
    #   res.on 'end', ->
    #     fs.writeFileSync path, file
    #     console.log(value, ' downloaded to ', path)
