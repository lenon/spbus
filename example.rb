require "spbus"

crawler = SpBus::Crawler.new
crawler.fetch_routes

puts "Found #{crawler.routes.size} routes"

crawler.routes.each do |route|
  puts "Fetching details for route #{route.number}"

  begin
    route.fetch_details

    puts <<-EOF
    Origin: #{route.origin}
    Destination: #{route.destination}
    Code for origin: #{route.code_for_origin}
    Code for destination: #{route.code_for_destination}
    EOF

  rescue SpBus::InconsistentResponse
    puts "Can't fetch details for #{route.number}"
  end
end

