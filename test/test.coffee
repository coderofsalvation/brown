brown = require('../index.coffee')

console.log brown.render "hello {{foo}}", {flop:{flap:123},foo:"world"}

brown.encode = (key) ->
  html = @[key] || ''
  String(html).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/</g, '&lt;').replace />/g, '&gt;'

data = 
  href:"/"
  label:"my \"label\""
  flop:
    flap: 123
  one:
    two: (arg) -> "foooooo "+arg

str  = '<a href="{{href}}" onclick="{{encode:label}}">{{flop.flap}} {{one.two:barrrrr}}</a>'
console.log brown.render str,data
