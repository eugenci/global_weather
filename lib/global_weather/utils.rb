module GlobalWeather
  module Utils

    def self.local_config
      current_file = File.expand_path(File.dirname(__FILE__))
      config = YAML.load(File.open(File.join(current_file,'..','..','config','global_weather.yml')))
      # convert string keys into symbols
      config.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    end

    # Returns local copy of wsdl schema file
    def self.local_wsdl_file
      current_file = File.expand_path(File.dirname(__FILE__))
      File.open(File.join(current_file,'..','..','config','globalweather.asmx.xml'))
    end

    # Camelize input string
    def camelize(lower_case_and_underscored_word)
      lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
    end

    # Removes <?xml ... /xml> header from xml string
    def fix_header!(string_xml)
      string_xml.gsub!(/\<\?.+\?\>/,'')
    end
  end
end

