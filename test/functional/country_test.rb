require_relative File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class CountryPositiveTests < Test::Unit::TestCase
  def test_basic_call
    country = GlobalWeather::Country.new 'Germany'
    assert country.cities.include?('Hannover'), "Following list of cities #{country.cities} does not include Hannover"
  end
end

class CountryNegativeTests < Test::Unit::TestCase
  def test_no_arguments_provided
    assert_raise GlobalWeather::CountryNotProvided do
      GlobalWeather::Country.new
    end
  end

  def test_invalid_country_provided
    assert_raise GlobalWeather::CountryInvalid do
      GlobalWeather::Country.new 'FarFarFarAway'
    end
  end
end
