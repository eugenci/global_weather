require_relative File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class UtilsTests < Test::Unit::TestCase

  include GlobalWeather::Utils

  def test_camelize
    assert_equal 'SkyConditions', camelize('sky_conditions')
    assert_equal 'Temperature', camelize('temperature')
    assert_equal 'RelativeHumidity', camelize('relative_humidity')
  end

  def test_fix_header
    assert_equal '<tag>Blah</tag>',fix_header!('<?xml some attributes here ?><tag>Blah</tag>')
  end
end
