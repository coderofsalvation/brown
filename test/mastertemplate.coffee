brown = require('./../index.coffee').parse

data = 
  master:
    html: 
      head: ''
      body:
        'div#main': '{{content()}}'
  page:
    'ul#menu':
      div: "{{foo}}"
  data:
    foo: "hello world"
  content: () -> brown @.page, @.data

console.log brown data.master, data
