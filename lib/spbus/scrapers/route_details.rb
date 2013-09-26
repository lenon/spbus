module SpBus::Scrapers
  class RouteDetails

    URL = "http://olhovivo.sptrans.com.br/v0/Linha/Buscar"

    def initialize(route)
      @route = route
    end

    def fetch
      doc = SpBus::Request.new(url_with_params).get
      @json = JSON.parse(doc, symbolize_names: true)

      validate_response
      build_route

      true
    end

    private

    def url_with_params
      params = URI.encode_www_form(termosBusca: @route.number)
      "#{URL}?#{params}"
    end

    def validate_response
      if @json.nil? ||
         @json.size != 2 ||
         @json[0][:DenominacaoTSTP] != @json[1][:DenominacaoTSTP] ||
         @json[0][:DenominacaoTPTS] != @json[1][:DenominacaoTPTS]
        raise SpBus::UnknownResponse
      end
    end

    def build_route
      origin      = find_origin
      destination = find_destination

      @route.origin    = origin[:DenominacaoTSTP]
      @route.origin_id = origin[:CodigoLinha] unless @route.one_way?

      @route.destination    = destination[:DenominacaoTPTS]
      @route.destination_id = destination[:CodigoLinha]
    end

    def find_origin
      @json.select { |h| h[:Sentido] == 2 }.first
    end

    def find_destination
      @json.select { |h| h[:Sentido] == 1 }.first
    end
  end
end

