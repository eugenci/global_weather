require_relative File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class GlobalWeatherTests < Test::Unit::TestCase
  def test_basic_call
    VCR.use_cassette('get_weather_basic_call') do
      weather = GlobalWeather::Weather.new 'Germany', 'Berlin'

      assert_equal 14,weather.temperature[:C]
      assert_equal 57, weather.temperature[:F]
      assert_equal 10, weather.dew_point[:C]
      assert_equal 50, weather.dew_point[:F]
      assert_equal 29.94, weather.pressure[:Hg]
      assert_equal 1014, weather.pressure[:hPa]
      assert weather.location =~ /Berlin/
      assert weather.location =~ /Germany/
      assert_equal 76, weather.relative_humidity
      assert_equal DateTime.new(2013,8,25,3,20,0), weather.time[:UTC]
    end
  end

  def test_convert_time_to_datetime
    output = GlobalWeather::Weather.send(:convert_time_to_datetime, 'Aug 21, 2013 - 11:21 AM EDT / 2013.08.21 1521 UTC')
    assert_equal DateTime.new(2013,8,21,15,21,0), output[:UTC]
    assert_equal DateTime.new(2013,8,21,15,21,0), output[:EDT]
  end

  def test_convert_pressure_to_hash_1
    output = GlobalWeather::Weather.send(:convert_pressure_to_hash, '20.34 in. Hg (688.79 hPa)')
    assert_equal output[:Hg], 20.34
    assert_equal output[:hg], 20.34
    assert_equal output[:hPa], 688.79
    assert_equal output[:hpa], 688.79
  end

  def test_convert_temperature_to_hash_1
    output = GlobalWeather::Weather.send(:convert_temperature_to_hash, '57 F (14 C)')
    assert_equal output[:F], 57
    assert_equal output[:f], 57
    assert_equal output[:c], 14
    assert_equal output[:C], 14
  end

  def test_convert_temperature_to_hash_2
    output = GlobalWeather::Weather.send(:convert_temperature_to_hash, ' -31 F (-35 C)')
    assert_equal output[:F], -31
    assert_equal output[:f], -31
    assert_equal output[:c], -35
    assert_equal output[:C], -35
  end

end
