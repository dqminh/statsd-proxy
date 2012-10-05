// # Sample client code for statsd-proxy
//
// How to use:
//    var statsd = new Statsd("stats.example.com", "app.production");
//    statsd.increment("test.inc", 0.1);
//    statsd.decrement("test.dec", 0.1);
//    statsd.timing("test.timing", 100, 0.1);
window.Statsd = (function($) {
  function Statsd(host, prefix) {
    this.host = host;
    this.prefix = prefix;
  }

  Statsd.prototype.send_request = function(endpoint, data) {
    var url = this.host + endpoint + "?" + $.param(data);
    var image = new Image();
    image.src = url;
    return false
  };

  Statsd.prototype.increment = function(name, sampleRate) {
    this.send_request("/increment", {
      name: this.prefix + "."  + name,
      sample_rate: sampleRate
    });
  };

  Statsd.prototype.decrement = function(name, sampleRate) {
    this.send_request("/decrement", {
      name: this.prefix + "."  + name,
      sample_rate: sampleRate
    });
  };

  Statsd.prototype.timing = function(name, value, sampleRate) {
    this.send_request("/timing", {
      name: this.prefix + "."  + name,
      value: value,
      sample_rate: sampleRate
    });
  };

  return Statsd;
})(jQuery);
