brown = require('./../index.coffee').parse

json = 
  div: 
    'span>b.foo': '{{foo}}'
    'span>b.bar': '{{func()}}'
    'span>b.pipe': '{{foo|upper|important}}'
    'div#foo.flop>fieldset>div>span': 
      ul: 'items->li>a[href="{{.url}}"]>{ {{.label|upper}} }'
    'div':
      ul: 'arr->li>{ {{.}} }'
      ol: 'arr->{{.|upper}}'

data = 
  items: [{label:'one', url:"/"},{label:'two',url:'/two'}]
  arr: [1,2,"three"] 
  foo: "hello world"
  func: () -> @.foo + " foobar"
  upper: (str) -> str.toUpperCase()
  important: (str) -> "!! "+str
      
console.log JSON.stringify json,null,2
console.log brown json, data

json = 
  div: "items->li{{.}}"
data = 
  items: [{label:'one', url:"/"},{label:'two',url:'/two'}]
