# dl_route_example.rb
#
# this tiny script downloads OP drives from "the cloud" to your box
#
#
# call this script via docker (recommended):
#
#   docker run -e ROUTE_ID="xxxxxxxx" makevoid/comma_ai_download_drive
#
# pass LOGS=1 to download all the logs:
#
#   docker run -e ROUTE_ID="xxxxxxxx" -e LOGS=1 makevoid/comma_ai_download_drive
#
#
# call via plain ruby:
#
#   ruby dl_route_example.rb ROUTE_ID="xxxxxxxx"
#
#
# note: you have to configure a working ruby environment to run this
#
# run one of the two scripts, these download to the current directory a bunch of video files of your OP drive
# use VLC or a similar app to play them
# enjoy!
#

require_relative 'env'

# get all the segments related to that route
routeFiles = CommaAPI::API.routeFiles route_name: ROUTE_ID
puts "routeFiles: #{routeFiles.size} found\n\n"

# download helper
def download(url, idx)
  idx = "%02d" % idx

  uri  = URI url
  req  = Net::HTTP::Get.new uri.request_uri
  req["Authorization"] = "JWT #{::JWT_TOKEN}"
  resp = CommaAPI::API.http(uri: uri).request req
  return RPCError404.new if resp.code == "404"

  resp.body
end

# download front camera by default

routeFiles.fetch("cameras").each_with_index do |camera_url, idx|
  data = download camera_url, idx
  File.open("route/video-#{idx}.hevc", "wb") do |file|
    file.write data
  end
end

if LOGS # pass LOGS=1 to download all logs

  routeFiles.fetch("logs").each_with_index do |log_url, idx|
    data = download log_url, idx
    File.open("route/log-#{idx}.bz2", "wb") do |file|
      file.write data
    end
  end

  routeFiles.fetch("qlogs").each_with_index do |log_url, idx|
    data = download log_url, idx
    File.open("route/qlog-#{idx}.bz2", "wb") do |file|
      file.write data
    end
  end

end
