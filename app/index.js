var generatePassphrase = require('eff-diceware-passphrase')
var express = require('express')
var package_info = require('./package.json')

var app = express()

app.get('/', function (req, res) {
  res.send({now: new Date()})
})

app.get('/:number', function (req, res) {
  res.send({password: generatePassphrase(parseInt(req.params.number, 10))})
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