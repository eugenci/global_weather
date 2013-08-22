module GlobalWeather
  class Weather

    ATTRIBUTES = %w(location time wind temperature
                    dew_point relative_humidity pressure sky_conditions
                    visibility)

    attr_reader *ATTRIBUTES

    def initialize(country = nil, city = nil)
      client = Savon.client wsdl: local_wsdl_file # included from Utils

      raise Errors::CityNotProvided if city.nil?
      raise Errors::CountryNotProvided if country.nil?

      response = client.call(:get_weather) do |locals|
        locals.message 'CountryName' => country, 'CityName' => city
      end

      if response.success?
        body   = response.hash[:envelope] && response.hash[:envelope][:body]
        if body
          result = body[:get_weather_response] && body[:get_weather_response][:get_weather_result]
          create_attributes(result)
        end
      end
    end

    private

    include Utils

    def create_attributes(string_xml_or_hash)
      # Current weather information are returning as xml string instead of hash
      # That is why I parse it here with Nori into a hash
      hrep = if string_xml_or_hash.is_a?(String)
               raise Errors::CityOrCountryInvalid if string_xml_or_hash =~ /Data Not Found/
               Nori.new.parse(fix_header!(string_xml_or_hash))
              # in case service will return result as hash, do nothing
             elsif string_xml_or_hash.is_a?(Hash)
               string_xml_or_hash
             end

      ATTRIBUTES.each do |attribute|
        # camelize method is included from Utils
        instance_variable_set("@#{attribute}", hrep['CurrentWeather'][camelize(attribute)])
      end
    end
  end
end
