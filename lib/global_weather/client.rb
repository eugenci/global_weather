module GlobalWeather

  class Client

    @@client = nil

    def self.connect(options = {})
      if @@client.nil?
        @@client = Savon.client({wsdl: Utils.local_wsdl_file}.merge(Utils.local_config)) # included from Utils
      else
        @@client
      end
    end
  end
end
