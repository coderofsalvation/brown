  var brown, extend, jdsl, json;

  brown = require('./../.');

  jdsl = require('json-dsl');

  extend = require('extend');

  jdsl.parseKey = function(k, data) {
    k = brown.micromustache.render(k, extend(brown.micromustache, data));
    if (k[0] !== '<') {
      return "<" + k + ">%s</" + k.split(' ')[0] + ">";
    } else {
      return k + "%s";
    }
  };

  jdsl.parseValue = function(v, data) {
    return brown.micromustache.render(v, extend(brown.micromustache, data));
  };

  brown.micromustache.encode = function(key) {
    var html;
    html = this[key] || '';
    return String(html).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
  };

  brown.render = function(input, data) {
    return jdsl.parse(input, data);
  };

  console.dir(Object.keys(brown.micromustache));

  json = {
    ul: {
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
