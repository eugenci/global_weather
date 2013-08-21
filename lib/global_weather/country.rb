module GlobalWeather
  class Country

    include Utils

    attr_reader :name, :cities

    def initialize(name = nil)
      client = Savon.client wsdl: local_wsdl_file # included from Utils

      raise Errors::CountryNotProvided if name.nil?

      response = client.call(:get_cities_by_country) do |locals|
        locals.message 'CountryName' => name
      end

      if response.success?
        body   = response.hash[:envelope] && @response.hash[:envelope][:body]
        if body
          result = body[:get_cities_by_country_response] && body[:get_cities_by_country_response][:get_cities_by_country_result]
          create_attributes(result)
        end
      end
    end

    private

    def create_attributes(result)
      hrep = Nori.new.parse(result)
      new_data_set = hrep && hrep['NewDataSet']
      if new_data_set
        hash_of_cities = new_data_set && new_data_set['Table']
        if hash_of_cities
          @cities = hash_of_cities.map{|item| item['City']}
        else
          raise Errors::InvalidResponseFormat, 'Unexpected response format'
        end
      else
        raise Errors::CountryInvalid, 'Returned data set is empty, probably because provided country is invalid'
      end
    end
  end
end
