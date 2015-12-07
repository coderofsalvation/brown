// Generated by CoffeeScript 1.9.3
(function() {
  module.exports = (function() {
    var me;
    me = this;
    this.safe_eval = function(str, data) {
      var FOO, evalstr, result;
      str = str.split(':')[0];
      result = "";
      try {
        evalstr = (!str.match(/\./) ? '["' + str + '"]' : '.' + str);
        result = new Function('return ( arguments[0]' + evalstr + ' )')(data);
      } catch (_error) {
        FOO = _error;
        result = '';
      }
      return result;
    };

    /**
     * Replaces every {{variable}} inside the template with values provided by data
     * If the value is a function, call it passing the name of the variable as the only argument.
     * @param template {string} the template containing one or more {{key}}
     * @param data {object} an object containing string (or number) values for every key that is used in the template
     * @return {string} template with its valid variable names replaced with corresponding values
     */
    this.render = function(template, data) {
      var k, v;
      if (typeof template !== 'string') {
        return template;
      }
      if (typeof data !== 'object' || data === null) {
        data = {};
      }
      for (k in me) {
        v = me[k];
        data[k] = v;
      }
      return template.replace(/\{?\{\{\s*(.*?)\s*\}\}\}?/g, function(match, varName) {
        var value;
        value = data[varName] || data[varName.split(':')[0]] || me.safe_eval(varName, data);
        switch (typeof value) {
          case 'string':
          case 'number':
          case 'boolean':
            return value;
          case 'function':
            return value.apply(data, varName.split(':').slice(1));
          default:
            return '';
        }
      });
    };
    return this;
  }).apply({});

}).call(this);
