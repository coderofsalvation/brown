<h1>ϐrown</h1>

JSON 2 html/xml template engine on steroids

# Usage 

    $ npm install brown

then 

    brown = require('brown').parse

    json = 
      'div#foo.flop>fieldset>div>span': 
        ul: 'items->li>a[href="{{.url}}"]>{ {{.label}} }'
      div: 
        'span>b.foo': '{{foo}}'
        'span>b.bar': '{{func()}}'
        'span>b.pip': '{{foo|upper|important}}'

    data = 
      items: [{label:'one', url:"/"},{label:'two',url:'/two'}]
      foo: "hello world"
      func: () -> @.foo + " foobar"
      upper: (str) -> str.toUpperCase()
      important: (str) -> "!! "+str
    
    brown json, data

> NOTE: instead of coffeescript, see the javascript example [here](https://github.com/coderofsalvation/brown/blob/master/test/test.js)

### output

    <div id="foo" class="flop">
      <fieldset>
        <div>
          <span>
            <ul>
              <li>
                <a href="/"> one </a>
              </li>
              <li>
                <a href="/two"> two </a>
              </li>
            </ul>
          </span>
        </div>
      </fieldset>
    </div>
    <div>
      <span>
        <b class="foo">hello world</b>
      </span>
      <span>
        <b class="bar">hello world foobar</b>
      </span>
      <span>
        <b class="pipe">!! HELLO WORLD</b>
      </span>
    </div>

# Philosophy

ϐrown wants to be very fast an minimal, therefore uses [json-dsl](https://npmjs.com/packages/json-dsl).
ϐrown combines ideas from smarty, mustache and emmet/zencoding.
ϐrown focuses on json and json-portability instead of text (smarty/mustache) or introducing a new syntax which require lexicalscanner/parsertree-bloat (jade,coffeecup,haml etc).

# Features

* variable substitution using {{variablename}}
* filter chaining using '|'
* functions using {{functionname()}}
* iteration over objects using '->' and {{.keyname}} 
* iteration over arrays using '->' and {{.}}

With these basics you can literally do anything. 
Need more? just use functions and filters. 

# Browser usage 

    <script type='text/javascript' src='brown.min.js'></script>
    <script>
      brown = require('brown');
      html = brown.parse( {"div":"{{foo}}"}, {foo:"bar"} )
      alert(html);
    </script>

# nested templates

Want master templates?
Easy, you can call brown inside brown.

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

    brown data.master, data

> NOTE: instead of coffeescript, see the javascript example [here](https://github.com/coderofsalvation/brown/blob/master/test/mastertemplate.js)

### output    

    <html><head></head><body><div id="main"><ul id="menu"><div>hello world</div></ul></div></body></html></body></head></html>    

# traversing arrays/objects

Arrays here you go

      div:
        ul: 'arr->li>{ {{.}} }'
        ol: 'arr->{{.|upper}}'

And for objects just reference the keys like so: `{{.keyname}}`

For more info see the info above or the [tests](https://github.com/coderofsalvation/brown/blob/master/test/test.js)

# global functions and filters 

Easy, just use extend (`npm install extend`).

    global = 
      somefilter: (str) -> str.toUpperCase()
      projectname: () -> return "myprojectname"

    unique =
      welcome: "hello"

    json = 
      div:
        span: '{{welcome}} {{projectname()|somefilter}}'

    console.log brown json, extend global, unique

### output

    <div><span>hello MYPROJECTNAME</span></div>


# Roadmap

* stability and peace
