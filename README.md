# GlobalWeather

[Global Weather SOAP
service](http://www.webservicex.net/WS/WSDetails.aspx?WSID=56&CATID=12)
ruby wrapper. 

## Installation

Add this line to your application's Gemfile:

    gem 'global_weather'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install global_weather

## Usage

Basically GlobalWeather gem provides 2 classes Country (wraps
GetCitiesByCountry soap method call) and Weather (wraps GetWeather method call)

To get cities by country (e.g. Germany)
   

      country = GlobalWeather::Country.new 'Germany'
     
      country.cities # returns an array of strings


In order to get current weather (e.g. country 'Germany', city 'Berlin')


      weather = GlobalWeather::Weather.new 'Germany', 'Berlin' 
       
      puts weather.time

      puts weather.temperature

      puts weather.pressure


See full list of attributes


      GlobalWeather::Weather::ATTRIBUTES


Can it be simplier?

## Test

Command 


    $ rake

or 


    $ rake test

will run all tests


## Configuration

  Global Weather gem has a config folder with global_weather.yml file
  where all configuration options goes. All configuration given in yaml
  file are passed further down to [Savon](http://savonrb.com/version2/)
  gem.
  Thus all options passed to Savon.client can be passed either from
  config/global_weather.yml file or directly as last argument in
  GlobalWeather::Weather and GlobalWeather::Country constructors.
