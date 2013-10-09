require "nokogiri"
require "open-uri"
require "json"
require "logger"

require "spbus/route"
require "spbus/bus"
require "spbus/request"
require "spbus/scrapers/routes"
require "spbus/scrapers/route_details"
require "spbus/scrapers/locations"

require "spbus/version"

module SpBus

  class UnknownResponse < StandardError ; end
  class InvalidRoute < StandardError ; end

  class << self

    attr_writer :logger

    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def fetch_routes
      scraper = Scrapers::Routes.new
      scraper.fetch

      scraper.routes.select do |route|
        logger.info "Fetching details for route #{route.number}..."

        begin
          Scrapers::RouteDetails.new(route).fetch
          if block_given?
            yield route
          else
            true
          end
        rescue InvalidRoute
          logger.warn "[INVALID ROUTE] #{route.number}"
          false
        end
      end
    end

    def fetch_buses(destination_id)
      scraper = Scrapers::Locations.new(destination_id)
      scraper.fetch
      scraper.buses
    end
  end
end

