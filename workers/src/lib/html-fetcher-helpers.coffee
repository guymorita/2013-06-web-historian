_ = require 'lodash'

exports.readUrls = (filePath, cb) ->
  console.log filePath, cb
  _.each filePath, (value) ->
    cb value

exports.downloadUrls = (urls) ->
  true
