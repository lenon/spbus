module SpBus
  class Client

    # Returns a new instance of SpBus::Client.
    #
    # @example
    #   client = SpBus::Client.new("api token")
    #
    # @param token [String] Your API token
    def initialize(token)
      @token = token
      @connection = Connection.new
    end

    # Do authentication. You must call this method before any request to
    # the API.
    #
    # @example
    #   client = SpBus::Client.new("api token")
    #   client.authenticate #=> true
    #
    # @return [Boolean] Returns true when successfully authenticated
    # @raise [AuthenticationError] when authentication fails
    def authenticate
      Authentication.new(@connection, @token).authorize
    end

    # Perform a search for a bus line.
    #
    # @example
    #   client.search("terminal capelinha") #=> [#<SpBus::Line ...>, ...]
    #
    # @param term [String]
    # @return [Array<Line>]
    def search(term)
      Search.new(@connection, term).results
    end

    # Returns all stops for a given line.
    #
    # @example
    #   client.stops(1273) #=> [#<SpBus::Stop ...>, ...]
    #
    # @param line [Integer] line id returned by {#search}
    # @return [Array<Stop>]
    def stops(line)
      LineStops.new(@connection, line).results
    end

    # Returns all available buses for a given line.
    #
    # @example
    #   client.buses(1273) #=> [#<SpBus::Bus ...>, ...]
    #
    # @param line [Integer] line id returned by {#search}
    # @return [Array<Bus>]
    def buses(line)
      LineBuses.new(@connection, line).results
    end
  end
end
