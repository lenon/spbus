# SpBus

A small Ruby client for SPTrans API which allows you retrieve information
about São Paulo city buses, lines, stops and real time schedules.

[![Code Climate](https://codeclimate.com/github/lenon/spbus.png)](https://codeclimate.com/github/lenon/spbus)
[![Gem Version](https://badge.fury.io/rb/spbus.png)](http://badge.fury.io/rb/spbus)
[![Build Status](https://travis-ci.org/lenon/spbus.png)](https://travis-ci.org/lenon/spbus)

## Installation

Add this line to your Gemfile:

    gem 'spbus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spbus

## Usage

First of all, get your API token from [SPTrans](http://www.sptrans.com.br/desenvolvedores/). Then you can play with the client:

    client = SpBus::Client.new("your api token")

#### Authentication

All API requests are authenticated. So, let's authenticate:

    client.authenticate #=> true

#### Search

    client.search("largo sao francisco") #=> [#<SpBus::Line ...>, #<SpBus::Line ...>, ...]

#### Line stops

    client.stops(line.id) #=> [#<SpBus::Stop ...>, #<SpBus::Stop ...>, ...]

#### Real-time

    client.buses(line.id) #=> [#<SpBus::Bus ...>, #<SpBus::Bus ...>, ...]

## Contributing

1. Fork it (http://github.com/lenon/spbus/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## To-do

* Improve documentation.
* Support more endpoints (like estimated time of arrival and bus lanes).
