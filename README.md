# Statsd Proxy

This proxy all HTTP request to a statsd server. The reason is because client
i.e. web browser cannot establish a UDP connection with statsd server.
Instead, the client is going to send HTTP GET request, and the proxy server
will translate that into UDP call to statsd server

Link: [statsd](https://github.com/etsy/statsd/)

## From HTTP to UDP

- Increment `/increment?name=production.inc&sample_rate=0.8`
- Decrement `/decrement?name=production.dec&sample_rate=0.8`
- Timing `/timing?name=production.timing&value=100&sample_rate=0.8`

## How to setup

This is designed to be deployed on Heroku. Knowledge on how to deployed on
heroku will be assumed. After deploy on heroku, the following config keys are
required:

- `STATSD_HOST`: host of statsd server
- `STATSD_PORT`: port of statsd server
- `RACK_ENV`: most likely you will set this to `production` 
