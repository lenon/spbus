require "rubygems"
require "bundler/setup"
require "vcr"
require "webmock"

require "spbus"

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("__SPTRANS_TOKEN__") { SpecEnv.valid_api_token }
  config.default_cassette_options = {
    :serialize_with => :json,
    :preserve_exact_body_bytes => true,
    :decode_compressed_response => true,
    :record => :once
  }
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = "random"
  config.include CustomHelpers
end

class SpecEnv
  class << self

    def valid_api_token
      ENV.fetch("SPTRANS_TOKEN", "x" * 64)
    end

    def invalid_api_token
      "a" * 64
    end

    def known_line
      1273
    end

    def unknown_line
      123456789
    end

    def known_search
      "largo sao francisco"
    end

    def unknown_search
      "parque da gare"
    end

    def known_search
      "largo sao francisco"
    end
  end
end
