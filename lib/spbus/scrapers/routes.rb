# encoding: utf-8

module SpBus::Scrapers
  class Routes

    ALL_ROUTES_URL     = "http://200.99.150.170/PlanOperWeb/linhaselecionada.asp"
    VALIDATOR_PATH     = "#contentScroll p:first-child"
    VALIDATOR_REGEX    = /Foram encontrados vários resultados para a sua busca/i
    ROUTE_PATH         = "#contentScroll ul li .labelHold"
    ROUTE_NUMBER_PATH  = ".linkLinha:nth-child(1)"
    ROUTE_NUMBER_REGEX = /Linha: (?<number>[a-z0-9]+[-][0-9a-z]+)/i
    WAY_PATH           = ".linkLinha:nth-child(2)"
    WAY_MATCHER        = /\(Ver Ida\)(?<two_way> \/ \(Ver Volta\))?/i
    SPACES             = /\u00A0|\t|\n|\r/

    attr_reader :routes

    def fetch
      make_request
      validate_response
      build_routes
      true
    end

    private

    def make_request
      request = SpBus::Request.new(ALL_ROUTES_URL)
      request.authenticated = false

      @doc = Nokogiri::HTML(request.get)
    end

    def validate_response
      if @doc.css(VALIDATOR_PATH).inner_text !~ VALIDATOR_REGEX
        raise SpBus::UnknownResponse
      end
    end

    def build_routes
      @routes = []

      @doc.css(ROUTE_PATH).each do |node|
        if route = build_route(node)
          @routes << route
        end
      end
    end

    def normalize(str)
      str.gsub(SPACES, " ").squeeze(" ").strip
    end

    def one_way?(node)
      text = normalize(node.css(WAY_PATH).inner_text)
      match = WAY_MATCHER.match(text)
      match && !match[:two_way]
    end

    def build_route(node)
      raw_number = normalize(node.css(ROUTE_NUMBER_PATH).inner_text)
      match = ROUTE_NUMBER_REGEX.match(raw_number)

      if match
        route = SpBus::Route.new(match[:number])
        route.one_way = one_way?(node)
        route
      else
        false
      end
    end
  end
end

