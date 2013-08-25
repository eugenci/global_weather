require 'savon'
require "global_weather/version"
require "global_weather/utils"
require "global_weather/client"
require "global_weather/errors"
require "global_weather/country"
require "global_weather/weather"

module GlobalWeather
  include Errors
end
