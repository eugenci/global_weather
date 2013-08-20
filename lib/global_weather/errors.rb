module GlobalWeather
  module Errors
    class CityNotProvided < Exception; end
    class CountryNotProvided < Exception; end
    class CityOrCountryInvalid < Exception; end
    class CountryInvalid < Exception; end
    class InvalidResponseFormat < Exception; end
  end
end
