zen = require 'zen-coding'

module.exports = ( () ->

  @.escapes = ["___","___"]

  @.jdsl = require 'json-dsl'
  @.jdsl.parseKey   = (k) -> zen k+'>{%s}'
  @.jdsl.parseValue = (v,data) -> 
    result = ''; items = false;
    if v.match /->/
      items = data[ v.split('->')[0] ]
      v = v.split('->')[1]
      for item in items 
        itemstr = v.replace /(\{\{)(.*?)(\}\})/g, ($0,$1,$2) ->
          if $2.length > 1 and $2[0] is '.'
            $2 = @.applyFiltersAndEval $2, item, data 
          else 
            $2 = @.applyFiltersAndEval $2, item, data 
        itemstr = zen itemstr if v.match />/ 
        result += itemstr
    else 
      result = v
      result = result.replace /(\{\{)(.*?)(\}\})/g, ($0,$1,$2) ->
        $2 = @.applyFiltersAndEval "."+$2, data, data 
    # cleanup zencoding
    result = result.replace /___/g, '' # zencoding cannot handle contentvalue with numbers { 1 }
    result = result.replace( / </g,'<' ).replace( /> /g,'>' )
    result

  @.applyFiltersAndEval = ($2,item,data) ->
    filters = @.getFilters($2).filters
    $2 = @.getFilters($2).str
    is_array = false
    if $2 == '.'
      is_array = true
      $2 = item 
    else
      $2 = "item"+$2 
      $2 = String( eval($2) ).replace /undefined/, ''
    $2 = @.applyFilters $2, filters, data 
    $2 = @.escapes[0] + $2 + escapes[1] if is_array
    $2 

  @.getFilters = (str) ->
    filters = []
    if str.match /|/
      filters = str.split '|'
      str = filters.shift()
    { str:str, filters:filters }

  @.applyFilters = (str,filters,data) ->
    if filters.length 
      str = eval 'data.'+filter+'("'+str+'")' for filter in filters
    return str

  @.parse = (json,data) -> 
    @.jdsl.parse json,data

  return @

)()
