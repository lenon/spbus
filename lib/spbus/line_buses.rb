module SpBus
  class LineBuses

    def initialize(connection, line)
      @connection = connection
      @line = line
    end

    def results
      response = @connection.get("Posicao", :codigoLinha => @line)
      results = MultiJson.load(response.body, :symbolize_keys => true)
      results[:vs].collect { |b| Bus.new(b) }
    end
  end
end
