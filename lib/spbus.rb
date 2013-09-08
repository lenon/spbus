require "rest_client"
require "nokogiri"
require "json"
require "spbus/version"
require "spbus/crawler"
require "spbus/route"
require "spbus/bus"
require "spbus/locations"

module SpBus
  class InconsistentResponse < StandardError ; end
end

