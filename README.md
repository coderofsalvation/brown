<h1>ϐrown</h1>

Jade-ish + Mustache-ish template engine on steroids in 846 gzipped kilobytes

# Usage 

    $ npm install brown

or in the browser:
 
    <script type='text/javascript' src='brown.min.js'></script>

## Simple

    brown.render( "hello {{foo.bar}}", { 
      foo: {
        bar: "world" 
      } 
    });

outputs:

    hello world

## Functions 

Create a fullfledged template engine by adding functions:

    brown.encode = function(key,type) {
      var html = this[key] || '';
      return  type == "html" ?
              String(html).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/</g, '&lt;').replace(/>/g, '&gt;') :
              html
    };

    brown.render( 'a href="{{href}}" onclick="{{encode:label:html}}"': "{{label}}", {
      href="/", 
      label:"my \"label\""} 
    });

outputs:

    <div>
      <ul>
        <li>
          <a href="/" onclick="my &quot;label&quot;">my "label"</a>
        </li>
      </ul>
    </div>

> Need more? See [if/foreach/filter/etc examples here](https://gist.github.com/coderofsalvation/93610d527c7b8534567f) on how to extend brown with [micromustache](https://www.npmjs.com/package/micromustache) functions.

## Generate xml/html from jsonportable JADE

ϐrown can be monkeypatched, to automatically produce xml-trees from json (like JADE), see this coffeescript example:

    json = 
      ul: 
        li: 'a href="{{foo}}": "Click me"
    
    brown.render json,{ foo: "/" }

outputs:

    <ul>
      <li>
        <a href="/">Click me </a>
      </li>
    </ul>

How? 
Simple, by just monkeypatching ϐrown with [json-dsl](https://npmjs.org/package/json-dsl). See [coffeescript](test/jadeish.coffee) / [JS](test/jadeish.js) examples.

## Commandline util

Use as a commandline generator (install using `npm install -g` ) :

      $ brown
        Usage: brown <string|file> [jsonstring|jsonfile]

      examples:
              $ brown 'foo {{foo}}' '{"foo":"world"}'
              $ brown foo.html data.json

# Goals / Philosophy

* lightweight and extendable 
* mustache without the noise (using [micromustache](https://www.npmjs.com/package/micromustache))

With these basics you can literally do anything. 
> Need more? See [more examples here](https://gist.github.com/coderofsalvation/93610d527c7b8534567f) on how to extend brown with [micromustache](https://www.npmjs.com/package/micromustache) functions.

# Roadmap

* stability and peace
