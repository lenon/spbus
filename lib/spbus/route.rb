module SpBus
  class Route

    attr_accessor :number, :origin, :destination, :origin_id, :destination_id
    attr_writer :one_way

    def initialize(number)
      @number = number
    end

    def one_way?
      !!@one_way
    end

    def fetch_details
      Scrapers::RouteDetails.new(self).fetch
    end
  end
end

