helpers = require('./lib/html-fetcher-helpers.js')
dataPath = '../../../data/sites.txt'

helpers.readUrls(dataPath, helpers.downloadUrls)
