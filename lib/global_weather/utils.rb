module GlobalWeather
  module Utils
    def camelize(lower_case_and_underscored_word)
      lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
    end

    def fix_header!(string_xml)
      string_xml.gsub!(/\<\?.+\?\>/,'')
    end
  end
end

