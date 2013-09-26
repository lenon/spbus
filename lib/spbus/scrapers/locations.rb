module SpBus::Scrapers
  class Locations

    URL = "http://olhovivo.sptrans.com.br/v0/Posicao"

    attr_reader :buses

    def initialize(destination_id)
      @destination_id = destination_id
    end

    def fetch
      doc = SpBus::Request.new(url_with_params).get
      @json = JSON.parse(doc, symbolize_names: true)

      validate_response

      @buses = @json[:vs].collect do |hash|
        build_bus(hash)
      end

      true
    end

    private

    def url_with_params
      params = URI.encode_www_form(codigoLinha: @destination_id)
      "#{URL}?#{params}"
    end

    def validate_response
      if @json.nil? ||
         @json[:hr].nil? ||
         @json[:hr].empty?
        raise SpBus::UnknownResponse
      end
    end

    def build_bus(hash)
      bus = SpBus::Bus.new
      bus.latitude = hash[:py]
      bus.longitude = hash[:px]
      bus
    end
  end
end

