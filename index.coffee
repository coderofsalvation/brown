module.exports = ( () ->

  merge = @merge = (source, obj, clone) ->
    return source if source == null or not source?
    for prop of obj
      v = obj[prop]
      if source[prop] != null and typeof source[prop] == 'object' and typeof obj[prop] == 'object'
        @merge source[prop], obj[prop]
      else
        if clone
          source[prop] = @clone
        else
          source[prop] = obj[prop]
    source

  @micromustache = require 'micromustache'
  @micromustache._render = @micromustache.render
  @micromustache.render = ( (str,data) ->
    @._render str, merge(data, @ )
  ).bind(@micromustache)

  @render = (input,data) ->
    return @micromustache.render input,data 

  ( @[k] = v.bind(@) if typeof v is 'function' ) for k,v of @ # me = this

  @

).apply({})
