require_relative "../app"
require "rack/test"

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
