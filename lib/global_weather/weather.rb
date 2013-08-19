module GlobalWeather
  class Weather

    ATTRIBUTES = %w(location time wind temperature
                    dew_point relative_humidity pressure sky_conditions
                    visibility)

    attr_reader *ATTRIBUTES

    def initialize(country = nil, city = nil)
      client = Savon.client wsdl: 'http://www.webservicex.net/globalweather.asmx?WSDL',
                             env_namespace: 'soap'

      raise Errors::CityNotProvided if city.nil?
      raise Errors::CountryNotProvided if country.nil?

      response = client.call(:get_weather) do |locals|
        locals.message 'CountryName' => country, 'CityName' => city
      end

      if response.success?
        result =  response &&
                    response.hash[:envelope] && 
                      response.hash[:envelope][:body] &&
                       response.hash[:envelope][:body][:get_weather_response] &&
                         response.hash[:envelope][:body][:get_weather_response][:get_weather_result]
        create_attributes(result)
      end
    end

    private

    def create_attributes(string_xml_or_hash)
      hrep = if string_xml_or_hash.is_a?(String)
               Nori.new.parse(fix_header!(string_xml_or_hash))
             elsif string_xml_or_hash.is_a?(Hash)
               string_xml_or_hash
             end

      ATTRIBUTES.each do |attribute|
        instance_variable_set("@#{attribute}", hrep['CurrentWeather'][camelize(attribute)])
      end
    end

    def camelize(lower_case_and_underscored_word)
      lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
    end

    def fix_header!(string_xml)
      string_xml.gsub!(/\<\?.+\?\>/,'')
    end
  end
end
