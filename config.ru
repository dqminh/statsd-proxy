require 'bundler'
Bundler.require
require './app'

use Rack::Cors do
  allow do
    origins %r(^http://(.+\.)?#{ENV["DEFAULT_HOST"]})
    resource "*", headers: :any, methods: [:get, :post, :options]
  end
end
run Sinatra::Application
