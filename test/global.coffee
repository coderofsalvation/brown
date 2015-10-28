extend = require 'extend'
brown = require('./../').parse

global = 
  somefilter: (str) -> str.toUpperCase()
  projectname: () -> return "myprojectname"

unique =
  welcome: "hello"

json = 
  div:
    span: '{{welcome}} {{projectname()|somefilter}}'

console.log brown json, extend global, unique
