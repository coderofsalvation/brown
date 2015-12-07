brown = require './../.'

jdsl   = require 'json-dsl'
extend = require 'extend'

jdsl.parseKey   = (k,data) -> 
  k = brown.micromustache.render k, extend( brown.micromustache,data)
  if k[0] != '<' then "<"+k+">%s</"+k.split(' ')[0]+">" else k+"%s"

jdsl.parseValue = (v,data) ->
  brown.micromustache.render v, extend( brown.micromustache, data)

brown.micromustache.encode = (key) ->
  html = @[key] || ''
  String(html).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/</g, '&lt;').replace />/g, '&gt;'

brown.render = (input,data) ->
  jdsl.parse input,data

console.dir Object.keys(brown.micromustache)

json =
  ul:
    li:
      'a href="{{href}}" onclick="{{encode:label}}"': "{{label}}"

console.log JSON.stringify json,null,2
console.log brown.render json, {href:"/",label:"my \"label\""}

