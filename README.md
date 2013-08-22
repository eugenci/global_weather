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

Basically GlobalWeather gem provides 2 classes Country (wrap
GetCitiesByCountry soap method call) and Weather (wraps GetWeather method call)

1. To get cities by country (e.g. Germany)
   

      country = GlobalWeather::Country.new 'Germany'
     
      country.cities # returns an array of strings


2. In order to get current weather (e.g. country 'Germany', city 'Berlin'):


      weather = GlobalWeather::Weather.new 'Germany', 'Berlin' 
       
      puts weather.time

      puts weather.temperature

      puts weather.pressure


  See full list of attributes:


      GlobalWeather::Weather::ATTRIBUTES


Can it be simplier?

## Test

Command 


    $ rake

or 


    $ rake test

will run all tests


