module SpBus
  class Client

    def initialize(token)
      @token = token
      @connection = Connection.new
    end

    def authenticate
      Authentication.new(@connection, @token).authorize
    end

    def search(term)
      Search.new(@connection, term).results
    end

    def stops(line)
      LineStops.new(@connection, line).results
    end

    def buses(line)
      LineBuses.new(@connection, line).results
    end
  end
end
