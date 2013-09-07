# encoding: utf-8

module SpBus
  class Route

    BUS_ROUTE_DETAILS = "http://200.189.189.54/InternetServices/BuscaLinhasSIM"

    attr_reader :number, :origin, :destination, :code_for_origin,
                :code_for_destination

    def initialize(number)
      @number = number
    end

    def fetch_details
      sptrans_request

      raise InconsistentResponse unless valid_response?

      @origin               = @response[0][:DenominacaoTSTP]
      @destination          = @response[1][:DenominacaoTPTS]
      @code_for_origin      = @response[0][:CodigoLinha]
      @code_for_destination = @response[1][:CodigoLinha]

      true
    end

    def to_h
      {
        number: number,
        origin: origin,
        destination: destination,
        code_for_origin: code_for_origin,
        code_for_destination: code_for_destination
      }
    end

    private

    def sptrans_request
      @response = JSON.parse(
        RestClient.get(BUS_ROUTE_DETAILS, params: { termosBusca: number }),
        symbolize_names: true
      )[:BuscaLinhasSIMResult]
    end

    def valid_response?
      !@response.nil? && @response.size == 2 &&
      @response[0][:DenominacaoTSTP] == @response[1][:DenominacaoTSTP] &&
      @response[0][:DenominacaoTPTS] == @response[1][:DenominacaoTPTS]
    end
  end
end

