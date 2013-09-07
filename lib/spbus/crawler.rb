# encoding: utf-8

module SpBus
  class Crawler

    BUS_ROUTES_URL       = "http://200.99.150.170/PlanOperWeb/linhaselecionada.asp"
    RESPONSE_VALIDATOR   = /Foram encontrados vários resultados para a sua busca/
    ROUTE_NUMBER_MATCHER = /Linha: (?<number>[a-z0-9]+[-][0-9a-z]+)/iu
    ROUTE_NUMBER_PATH    = "#contentScroll ul li .linkLinha:first-child"

    attr_reader :routes

    def initialize
      @routes = []
    end

    def fetch_routes
      sptrans_request

      raise InconsistentResponse unless valid_response?

      @response.css(ROUTE_NUMBER_PATH).each do |el|
        create_route_from_raw(el.content)
      end

      true
    end

    private

    def sptrans_request
      @response = Nokogiri::HTML(RestClient.get(BUS_ROUTES_URL))
    end

    def valid_response?
      @response.text =~ RESPONSE_VALIDATOR
    end

    def clean_raw_route(raw)
      raw.strip.gsub("\u00A0", " ")
    end

    def create_route_from_raw(str)
      match = ROUTE_NUMBER_MATCHER.match(clean_raw_route(str))

      if match
        @routes << Route.new(match[:number])
      end
    end
  end
end

