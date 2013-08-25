module GlobalWeather
  class Weather

    ATTRIBUTES = %w(location time wind temperature
                    dew_point relative_humidity pressure sky_conditions
                    visibility)

    attr_reader *ATTRIBUTES

    def initialize(country = nil, city = nil, options = {})

      client = Client.connect(options)

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
      else
        raise Errors::RequestFailure, 'Request to SOAP service failed'
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

      @temperature       = Weather.convert_temperature_to_hash(@temperature)
      @time              = Weather.convert_time_to_datetime(@time)
      @dew_point         = Weather.convert_temperature_to_hash(@dew_point)
      @pressure          = Weather.convert_pressure_to_hash(@pressure)
      @relative_humidity = @relative_humidity.to_i
    end

    def self.convert_temperature_to_hash(input)
      output = {}
      /\s*(?<fahrenheit>\-?\d+) F\s*\((?<celsius>\-?\d+) C\)/ =~ input
      output[:c] = output[:C] = celsius.to_i
      output[:f] = output[:F] = fahrenheit.to_i
      output
    end
    # Aug 24, 2013 - 11:20 PM EDT / 2013.08.25 0320 UTC&
    def self.convert_time_to_datetime(input)
      output = {}
      edt_and_utc = input.split('/')
      if edt_and_utc
        output[:EDT] = output[:edt] = DateTime.parse(edt_and_utc[0].strip) unless edt_and_utc[0].nil?
        output[:UTC] = output[:utc] = DateTime.strptime(edt_and_utc[1].strip,'%Y.%m.%d %H%M UTC') unless edt_and_utc[1].nil?
      end
      output
    end

    def self.convert_pressure_to_hash(input)
      output = {}
      /\s*(?<hg>\d+\.*\d* in\. Hg) \s*\((?<hpa>\d+\.*\d*) hPa\)/ =~ input
      output[:Hg] = output[:hg] = hg.to_f
      output[:hPa] = output[:hpa] = hpa.to_f
      output
    end
  end
end
