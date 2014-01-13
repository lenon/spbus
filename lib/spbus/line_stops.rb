module SpBus
  class LineStops

    def initialize(connection, line)
      @connection = connection
      @line = line
    end

    def results
      response = @connection.get("Parada/BuscarParadasPorLinha", :codigoLinha => @line)
      results = MultiJson.load(response.body, :symbolize_keys => true)
      results.collect { |s| Stop.new(s) }
    end
  end
end
