module GlobalWeather

  class Client
    @@client = nil
    @@config = {}

    def self.connect(options = {})

      @@config.merge!(options)

      if @@client.nil?
        @@client = Savon.client({wsdl: Utils.local_wsdl_file}.merge(@@config))
      else
        @@client
      end
    end

    def self.configure(&block)
      class_eval &block
    end

    class << self
      def method_missing(name, *args)
        @@config[name.to_sym] = args[0]
      end
    end

  end
end
