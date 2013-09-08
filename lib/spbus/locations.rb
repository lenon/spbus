module SpBus
  class Locations
    BUSES_LOCATIONS = "http://200.189.189.54/InternetServices/PosicaoLinha"

    attr_reader :buses

    def initialize(route)
      @route = route
    end

    def fetch_locations
      sptrans_request

      raise InconsistentResponse unless valid_response?

      @buses = @response[:vs].collect do |hash|
        SpBus::Bus.new(lat: hash[:py], long: hash[:px])
      end

      true
    end

    private

    def sptrans_request
      @response = JSON.parse(
        RestClient.get(BUSES_LOCATIONS, params: { codigoLinha: @route }),
        symbolize_names: true
      )[:PosicaoLinhaResult]
    end

    def valid_response?
      !@response.nil? && !@response[:hr].nil? && !@response[:hr].empty?
    end
  end
end

