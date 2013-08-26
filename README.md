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

This gem was tested on ruby 1.9.3p327 and ruby 2.0.0p0

## Usage

Basically GlobalWeather gem provides 2 classes Country (wraps
GetCitiesByCountry soap method call) and Weather (wraps GetWeather method call)

To get cities by country (e.g. Germany)
   

      country = GlobalWeather::Country.new 'Germany'
     
      country.cities # returns an array of strings


In order to get current weather (e.g. country 'Germany', city 'Berlin')


      weather = GlobalWeather::Weather.new 'Germany', 'Berlin' 
       
      puts weather.time[:UTC]

      puts weather.temperature[:C]

      puts weather.temperature[:F]

      puts weather.pressure[:Hg]

      puts weather.pressure[:hPa]


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

There is only one client instance shared among all instances of GlobalWeather
Weather and Country objects. 


    GlobalWeather::Client.configure do |config|
      config.log false
      config.proxy 'http://my_company_internal_proxy'
    end


options provided this way will be passed further down to Savon.client. See full list of all
at [savon documentation](http://savonrb.com/version2/globals.html)
