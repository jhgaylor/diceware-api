var package_info = require('./package.json')
var express = require('express')
var app = express()

app.get('/', function (req, res) {
  res.send({now: new Date()})
})

app.get('/health', function (req, res) {
  res.send({
    healthy: true,
    version: package_info.version
  })
})

app.listen(3000, function () {
  console.log('Simple diceware listening on port 3000!')
})