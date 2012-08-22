require_relative "../app"
require "rack/test"

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

module XhrHelper
  def xhr(path, params = { })
    verb = params.delete(:as) || :get
    send(verb, path, params, "HTTP_X_REQUESTED_WITH" => "XMLHttpRequest")
  end
  alias_method :ajax, :xhr
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include XhrHelper
end
