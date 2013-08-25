require_relative File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class GlobalWeatherPositiveTests < Test::Unit::TestCase
  def test_basic_call
    VCR.use_cassette('get_weather_basic_call') do
      weather = GlobalWeather::Weather.new 'Germany', 'Berlin', log: false

      assert weather.time =~ /UTC/
      assert weather.location =~ /Berlin/
      assert weather.location =~ /Germany/
      assert weather.temperature =~ /C/
      assert weather.pressure =~ /Hg/
      assert weather.relative_humidity =~ /%/
      assert weather.dew_point =~ /C/
    end
  end
end

class GlobalWeatherNegativeTests < Test::Unit::TestCase
  def test_no_arguments_provided
    assert_raise GlobalWeather::CityNotProvided, GlobalWeather::CountryNotProvided do
      GlobalWeather::Weather.new
    end
  end

  def test_city_or_country_invalid_1
    VCR.use_cassette('get_weather_invalid_1') do
      assert_raise GlobalWeather::CityOrCountryInvalid do
        GlobalWeather::Weather.new 'Blah', 'Berlin'
      end
    end
  end

  def test_city_or_country_invalid_2
    VCR.use_cassette('get_weather_invalid_2') do
      assert_raise GlobalWeather::CityOrCountryInvalid do
        GlobalWeather::Weather.new 'Germany', 'Blah'
      end
    end
  end

  def test_city_or_country_invalid_3
    VCR.use_cassette('get_weather_invalid_3') do
      assert_raise GlobalWeather::CityOrCountryInvalid do
        GlobalWeather::Weather.new 'Blah', 'Blah'
      end
    end
  end
end
