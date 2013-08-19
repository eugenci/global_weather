require_relative File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class GlobalWeatherPositiveTests < Test::Unit::TestCase
  def test_basic_call
    weather = GlobalWeather::Weather.new 'Germany', 'Berlin'

    assert weather.time =~ /UTC/
    assert weather.location =~ /Berlin/
    assert weather.location =~ /Germany/
    assert weather.temperature =~ /C/
    assert weather.pressure =~ /Hg/
    assert weather.relative_humidity =~ /%/
    assert weather.dew_point =~ /C/
  end
end

class GlobalWeatherNegativeTests < Test::Unit::TestCase
  def test_no_arguments_provided
    assert_raise GlobalWeather::CityNotProvided, GlobalWeather::CountryNotProvided do
      GlobalWeather::Weather.new
    end
  end

  def test_invalid_city_provided
  end

  def test_invalid_country_provided
  end
end
