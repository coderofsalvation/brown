#!/usr/bin/env node
brown = require( __dirname+"/.")
var data = {}
if( process.argv.length <3 ){
  console.log( "Usage: brown <string|jsonstring|jsonfile> [jsonstring|jsonfile]" );
  console.log( "\nexamples:\n\t$ brown 'foo {{foo}}' '{\"foo\":\"world\"}'");
  console.log( "\t$ brown html.json data.json\n\t$ brown html.json '{\"foo\":\"world\"}'");
  process.exit()
}

function get(input){
  var obj = input;
  try {
    obj = require('fs').readFileSync( input ).toString()
  }catch(e){ }
  if( obj[0] == "{" )
    obj = JSON.parse(obj);
  return obj
}
var input = get(process.argv[2]);
var data  = get(process.argv[3] || '');
console.dir(input);
console.dir(data);

console.log( brown.render( input, data ) );
