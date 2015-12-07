brown = require('../index.coffee')

console.log brown.render "hello {{foo}}", {foo:"world"}

brown.micromustache.encode = (key) ->
  html = @[key] || ''
  String(html).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/</g, '&lt;').replace />/g, '&gt;'

data = {href:"/",label:"my \"label\""}
str  = '<a href="{{href}}" onclick="{{encode:label}}">foo</a>'
console.log brown.render str,data
