# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'global_weather/version'

Gem::Specification.new do |spec|
  spec.name          = "global_weather"
  spec.version       = GlobalWeather::VERSION
  spec.authors       = ["Eugen Ciur"]
  spec.email         = ["ciur.eugen@gmail.com"]
  spec.description   = %q{GlobalWeather SOAP service wrapper}
  spec.summary       = %q{Provides Weather and Country objects to use easy GlobalWeather service}
  spec.homepage      = ""
  spec.license       = "MIT or Do whatever you want with this gem!"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', "~> 1.3"
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'debugger'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock', '~> 1.8'
  spec.add_dependency 'savon', '~> 2.0'
  spec.add_dependency 'nori', "~> 2.3.0"
end
