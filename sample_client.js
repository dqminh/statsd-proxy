window.Statsd = (function($) {
  function Statsd(prefix) {
    this.prefix = prefix;
  }

  Statsd.prototype.increment = function(name, sampleRate) {
    var prefix = this.prefix;
    $.get('/increment', {
      name: prefix + "." + name,
      sampleRate: sampleRate
    });
  }

  Statsd.prototype.decrement= function(name, sampleRate) {
    var prefix = this.prefix;
    $.get('/decrement', {
      name: prefix + "." + name,
      sampleRate: sampleRate
    });
  }

  Statsd.prototype.timing= function(name, value, sampleRate) {
    var prefix = this.prefix;
    $.get('/timing', {
      name: prefix + "." + name,
      value: value,
      sampleRate: sampleRate
    });
  }

  return Statsd;
})(jQuery);
