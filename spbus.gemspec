# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spbus/version'

Gem::Specification.new do |spec|
  spec.name          = "spbus"
  spec.version       = SpBus::VERSION
  spec.authors       = ["Lenon Marcel"]
  spec.email         = ["lenon.marcel@gmail.com"]
  spec.summary       = "Ruby client for the SPTrans (São Paulo Transporte) API."
  spec.description   = <<-DESC
    A small Ruby client for SPTrans API which allows you to retrieve data
    about São Paulo city buses, lines, stops and real-time (GPS) information.
  DESC
  spec.homepage      = "https://github.com/lenon/spbus"
  spec.license       = "MIT"

  spec.files         = Dir['{lib}/**/*', 'README*']
  spec.test_files    = Dir['{spec}/**/*']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.1.1"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "webmock", "~> 1.15.2"
  spec.add_development_dependency "vcr", "~> 2.8.0"

  spec.add_dependency "httparty", "~> 0.12.0"
  spec.add_dependency "http-cookie", "~> 1.0.2"
  spec.add_dependency "multi_json", "~> 1.8.4"
  spec.add_dependency "hashie", "~> 2.0.5"
end
