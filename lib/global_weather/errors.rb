module GlobalWeather
  module Errors
    class CityNotProvided < Exception; end
    class CountryNotProvided < Exception; end
    class CityOrCountryInvalid < Exception; end
  end
end
