module.exports = ( () ->

  me = @

  @safe_eval = (str,data) -> 
    str = str.split(':')[0]
    try
      result = new Function( 'return ( arguments[0]["' + str + '"] )' )(data);
    catch FOO
      result =  ''
    return result

  ###*
  # Replaces every {{variable}} inside the template with values provided by data
  # If the value is a function, call it passing the name of the variable as the only argument.
  # @param template {string} the template containing one or more {{key}}
  # @param data {object} an object containing string (or number) values for every key that is used in the template
  # @return {string} template with its valid variable names replaced with corresponding values
  ###

  @render = (template, data) ->
    return template if typeof template != 'string'
    # if data is not a valid object, assume it is an empty object which effectively removes all variable assignments
    data = {} if typeof data != 'object' or data == null
    data[k] = v for k,v of me
    template.replace /\{?\{\{\s*(.*?)\s*\}\}\}?/g, (match, varName) ->
      value = data[varName] || data[ varName.split(':')[0] ] || me.safe_eval varName, data 
      switch typeof value
        when 'string', 'number', 'boolean'
          return value
        when 'function'
          #if the value is a function, call it passing the variable name
          return value.apply(data, varName.split(':').slice(1))
        else
          #anything else will be replaced with an empty string. This includes object, array, date, regexp and null.
          return ''
      return

  @

).apply({})
