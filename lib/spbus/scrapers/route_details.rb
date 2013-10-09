module SpBus::Scrapers
  class RouteDetails

    URL = "http://200.189.189.54/InternetServices/BuscaLinhasSIM"

    def initialize(route)
      @route = route
    end

    def fetch
      doc = SpBus::Request.new(url_with_params).get
      @json = JSON.parse(doc, symbolize_names: true)[:BuscaLinhasSIMResult]

      validate_response
      build_route

      true
    rescue OpenURI::HTTPError => e
      if e.io && e.io.status.first.to_i == 500
        raise SpBus::InvalidRoute
      else
        raise e
      end
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
        raise SpBus::InvalidRoute
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

