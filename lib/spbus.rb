require "multi_json"
require "httparty"
require "http-cookie"
require "hashie/trash"

require "spbus/authentication"
require "spbus/client"
require "spbus/connection"
require "spbus/line_buses"
require "spbus/line_stops"
require "spbus/resources/bus"
require "spbus/resources/line"
require "spbus/resources/stop"
require "spbus/search"
require "spbus/version"

module SpBus

  class AuthenticationError < StandardError ; end
  class HTTPError < StandardError ; end

  class << self
    attr_writer :endpoint

    # Returns the API base url.
    #
    # @example
    #   SpBus.endpoint #=> "http://api.olhovivo.sptrans.com.br/v0/"
    #   SpBus.endpoint = "http://myproxyapi.com/"
    #
    # @return [String]
    def endpoint
      @endpoint ||= "http://api.olhovivo.sptrans.com.br/v0/"
    end
  end
end
