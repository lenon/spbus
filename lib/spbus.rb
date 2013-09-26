require "nokogiri"
require "open-uri"
require "json"

require "spbus/route"
require "spbus/bus"
require "spbus/request"
require "spbus/scrapers/routes"
require "spbus/scrapers/route_details"
require "spbus/scrapers/locations"

require "spbus/version"

module SpBus

  class UnknownResponse < StandardError ; end

  def self.fetch_routes
    scraper = Scrapers::Routes.new
    scraper.fetch
    scraper.routes.each(&:fetch_details)
    scraper.routes
  end

  def self.fetch_buses(destination_id)
    scraper = Scrapers::Locations.new(destination_id)
    scraper.fetch
    scraper.buses
  end
end

