# ruby dl_route.rb <route_id>

require_relative '../../lib/comma-api-rb'

route_id = ENV["ROUTE_ID"] || "........" # put here your route id
route_id = CGI.escape route_id

routeFiles = CommaAPI.routeFiles route_name: route_id
puts "routeFiles: #{routeFiles}\n\n"

routeFiles.fetch("cameras").each_with_index do |camera, idx|
  url  = camera
  uri  = URI url
  req  = Net::HTTP::Get.new uri.request_uri
  req["Authorization"] = "JWT #{::JWT_TOKEN}"
  resp = CommaAPI.http(uri: uri).request req
  return RPCError404.new if resp.code == "404"

  data = resp.body
  idx = "%02d" % idx
  File.open("video-#{idx}.hevc", "wb") do |file|
    file.write data
  end
end
