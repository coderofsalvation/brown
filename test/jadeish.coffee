brown = require './../.'

jdsl   = require 'json-dsl'
jdsl.parseKey   = (key,data) -> 
  data[k] = v for k,v of brown
  key = brown._render key, data
  if key[0] != '<' then "<"+key+">%s</"+key.split(' ')[0]+">" else key+"%s"
jdsl.parseValue = (value,data) ->
  data[k] = v for k,v of brown
  brown._render value, data

brown.encode = (key) ->
  html = @[key] || ''
  String(html).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/</g, '&lt;').replace />/g, '&gt;'

brown._render = brown.render 
brown.render = (input,data) ->
  jdsl.parse input,data

json =
  ul: 
    foo: "bar"
    li:
      'a href="{{href}}" onclick="{{encode:label}}"': "{{label}}"
    li:
      'a href="{{href}}" onclick="{{encode:label}}"': "{{label}}"

console.log JSON.stringify json,null,2
console.log brown.render json, {href:"/",label:"my \"label\""}

