#!/usr/bin/env node
brown = require( __dirname+"/.")

obj = {}
obj[process.argv[2]] = ''
console.log( brown.parse( obj,{} ) );
