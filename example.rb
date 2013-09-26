require "spbus"
require "pry"

puts "Fetching all routes..."

routes = SpBus.fetch_routes

puts "Found #{routes.size} routes"

routes.each do |route|
  puts <<-EOF
  Number:         #{route.number}
  Origin:         #{route.origin}
  Destination:    #{route.destination}
  One way?:       #{route.one_way?}
  Origin id:      #{route.origin_id}
  Destination id: #{route.destination_id}
  --------------------------------------------------
  EOF
end

