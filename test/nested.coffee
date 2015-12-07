brown = require './../.'

brown.micromustache.eval = (arg) ->
  console.log arg
  console.dir @
  v = eval("this." +arg );
  return (v != null ? v : '');

console.log brown.render "{{eval:foo.bar}}", {foo:{bar:"flop"}}

