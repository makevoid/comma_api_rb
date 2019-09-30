require_relative '../lib/comma-api-rb'

# example usage:
#
# ruby route_info_example.rb ROUTE_ID="..." JWT_TOKEN=...


# read readme, get your drive's route id pass it as an env variable

route_id = ENV["ROUTE_ID"]

puts "ROUTE_ID: #{route_id}"

raise CommaAPI::RouteIDRequiredError unless route_id

me = CommaAPI::API.me()
puts "me: #{me}\n\n"

route_id = CGI.escape route_id

segments = CommaAPI::API.deviceDefaultSegments
puts "segments (count): #{segments.size}\n\n - edit the file for the full list`"
puts "segments: #{segments.map{ |segment| segment["url"] }[-21..-1].inspect}\n\n"

route = CommaAPI::API.route route_name: route_id
puts "route: #{route}\n\n"

routeFiles = CommaAPI::API.routeFiles route_name: route_id
puts "routeFiles: #{routeFiles}\n\n"
