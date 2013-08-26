require 'test/unit'
require 'vcr'
require 'global_weather'
require 'debugger'

VCR.configure do |c|
  c.cassette_library_dir = File.join(File.expand_path(File.dirname(__FILE__)),'vcr','vcr_cassettes')
  c.hook_into :webmock 
  c.allow_http_connections_when_no_cassette = true
end


# all configuration here are passed as options for Savon client
# see full list http://savonrb.com/version2/globals.html
GlobalWeather::Client.configure do |config|
  config.log  false
end
