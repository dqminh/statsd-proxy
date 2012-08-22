// # Sample client code for statsd-proxy
//
// How to use:
//    var statsd = new Statsd("app.production");
//    statsd.increment("test.inc", 0.1);
//    statsd.decrement("test.dec", 0.1);
//    statsd.timing("test.timing", 100, 0.1);
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
