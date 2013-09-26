# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spbus/version'

Gem::Specification.new do |spec|
  spec.name          = "spbus"
  spec.version       = SpBus::VERSION
  spec.authors       = ["Lenon Marcel"]
  spec.email         = ["lenon.marcel@gmail.com"]
  spec.description   = %q{Easily retrieve information about São Paulo bus routes}
  spec.summary       = %q{A gem to easily retrieve information about São Paulo bus routes, numbers, location, etc using SPTrans web services.}
  spec.homepage      = "http://github.com/lenon/spbus"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "pry"

  spec.add_dependency "nokogiri"
end

