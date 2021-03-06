// Generated by CoffeeScript 1.10.0
(function() {
  var brown, jdsl, json;

  brown = require('./../.');

  jdsl = require('json-dsl');

  jdsl.parseKey = function(key, data) {
    var k, v;
    for (k in brown) {
      v = brown[k];
      data[k] = v;
    }
    key = brown._render(key, data);
    if (key[0] !== '<') {
      return "<" + key + ">%s</" + key.split(' ')[0] + ">";
    } else {
      return key + "%s";
    }
  };

  jdsl.parseValue = function(value, data) {
    var k, v;
    for (k in brown) {
      v = brown[k];
      data[k] = v;
    }
    return brown._render(value, data);
  };

  brown.encode = function(key) {
    var html;
    html = this[key] || '';
    return String(html).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
  };

  brown._render = brown.render;

  brown.render = function(input, data) {
    return jdsl.parse(input, data);
  };

  json = {
    ul: {
      foo: "bar",
      li: {
        'a href="{{href}}" onclick="{{encode:label}}"': "{{label}}"
      },
      li: {
        'a href="{{href}}" onclick="{{encode:label}}"': "{{label}}"
      }
    }
  };

  console.log(JSON.stringify(json, null, 2));

  console.log(brown.render(json, {
    href: "/",
    label: "my \"label\""
  }));

}).call(this);
