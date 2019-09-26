# ruby dl_route.rb <route_id>

require_relative '../lib/comma-api-rb'

me = CommaAPI.me()
puts "me: #{me}\n\n"

# choose ID and uncomment

# route_id = "xxx|2019-xxx"
#
# route_id = CGI.escape route_id
#
#
# segments = CommaAPI.deviceDefaultSegments
# puts "segments: #{segments}\n\n"
#
#
# route = CommaAPI.route route_name: route_id
# puts "route: #{route}\n\n"
#
#
# routeFiles = CommaAPI.routeFiles route_name: route_id
# puts "routeFiles: #{routeFiles}\n\n"
