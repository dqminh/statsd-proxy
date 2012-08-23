ENV["BUNDLE_GEMFILE"] = File.expand_path("./Gemfile", File.dirname(__FILE__))
RACK_ENV ||= ENV["RACK_ENV"] || "development"

require "bundler/setup"
require "sinatra"
require "sinatra/reloader" if RACK_ENV == "development"
require "statsd"
require "rack/cors"

# Default app settings
set :environment, RACK_ENV.to_sym
set :logging, true
set :raise_errors, true
set :protection, :except => :json_csrf # https://github.com/sinatra/sinatra/issues/518

def build_client
  Statsd.new ENV['STATSD_HOST'], ENV['STATSD_PORT']
end

def statsd
  if settings.test?
    build_client
  else
    $statsd ||= build_client
  end
end

get '/increment' do
  args = [params["name"]]
  args << params["sample_rate"].to_f if params["sample_rate"]
  statsd.increment *args
  204
end

get '/decrement' do
  args = [params["name"]]
  args << params["sample_rate"].to_f if params["sample_rate"]
  statsd.decrement *args
  204
end

get '/timing' do
  args = [params["name"], params["value"].to_f]
  args << params["sample_rate"].to_f if params["sample_rate"]
  statsd.timing *args
  204
end
