module SpBus
  class Search

    def initialize(connection, terms)
      @connection = connection
      @terms = terms
    end

    def results
      response = @connection.get("Linha/Buscar", :termosBusca => @terms)
      results = MultiJson.load(response.body, :symbolize_keys => true)
      results.collect { |l| Line.new(l) }
    end
  end
end
