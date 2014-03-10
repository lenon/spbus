# SpBus

A small Ruby client for [SPTrans API][1] which allows you to retrieve data
about São Paulo city buses, lines, stops and real-time (GPS) information.

[![Code Climate](https://codeclimate.com/github/lenon/spbus.png)][2]
[![Gem Version](https://badge.fury.io/rb/spbus.png)][3]
[![Build Status](https://travis-ci.org/lenon/spbus.png)][4]

## Installation

Add this line to your Gemfile:

    gem 'spbus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spbus

## Usage

First of all, get your API token at [SPTrans developers][1] page.
Then you can play with the client:

    client = SpBus::Client.new("your api token goes here")

#### Authentication

Before do any request, client must be authenticated. So, let's authenticate:

    client.authenticate #=> true

#### Search

    client.search("largo sao francisco") #=> [#<SpBus::Line ...>, #<SpBus::Line ...>, ...]

#### Line stops

    client.stops(line.id) #=> [#<SpBus::Stop ...>, #<SpBus::Stop ...>, ...]

#### Real-time (GPS)

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

[1]: http://www.sptrans.com.br/desenvolvedores
[2]: https://codeclimate.com/github/lenon/spbus
[3]: http://badge.fury.io/rb/spbus
[4]: https://travis-ci.org/lenon/spbus
