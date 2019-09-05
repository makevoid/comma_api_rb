require_relative '../api_client'

me = CommaAPI.me()
puts "me: #{me}\n\n"

# ---

# device = CommaAPI.deviceDefault()
# puts "device: #{device}\n\n"

# lat - lng - speed - gps accuracy - gps timestamp - gps bearing
# last_gps_lat - last_gps_lng - last_gps_speed - last_gps_accuracy - last_gps_time - last_gps_bearing

# ---

deviceLoc = CommaAPI.deviceDefaultLocation()
puts "device location: #{deviceLoc}\n\n"
# # lat lng time speed bearing
# # note - takes long ? because device is offline?


puts "Example loop and update via SSE" # - https://github.com/appliedblockchain/roda-react-sse

# Example where I use roda and SSE events ( needs full roda app - code from https://github.com/appliedblockchain/roda-react-sse )

module FormatStream

  SSE_IDS = {}

  Format = -> (stream, hash) {
    out = ""
    id = SSE_IDS[:stream] || 0 # we need an auto-increment id for the sse to work
    # this is the (simple) output format - id: ID \n data: [JSON] \n\n
    out << "id: #{id}\n"
    out << "data: #{JSONDump.(hash)} \n\n" # json data
    SSE_IDS[:stream] = id
    out
  }

  # private

  JSONDump = -> (hash) {
    Oj.dump(hash, mode: :compat)
  }

end

Log = -> (msg) {
  puts msg
}

FetchLocation = -> {
  deviceLoc = CommaAPI.deviceDefaultLocation()
  Log.("new device location: #{deviceLoc}\n\n")
  deviceLoc
}

r.on "updates" do
  response['Access-Control-Allow-Origin'] = CONFIG[:host]
  response['Content-Type'] = 'text/event-stream'
  stream do |out|
    while true do
      data = FetchLocation.()
      out << FormatStream::Format.(:update_location, data)
      sleep 3
    end
  end
end

# --------------------

# JS

JS = `
const source = new EventSource('/subscribe')

const logData = function(data) {
  log.innerText += '\n' + data
}

source.addEventListener('message', (event) => {
  logData(event.data)
}, false)
`



# --------------------

# stats = CommaAPI.deviceDefaultStats()
# puts "device stats: #{stats}\n\n"
# distance, minutes, routes
# total stats: miles driven, minutes, number of sessions



# devices = CommaAPI.devices()
# puts "devices: #{devices}\n\n"

# segments = CommaAPI.segments()
# puts "segments: #{segments}\n\n"

# others to try
#
# stats = CommaAPI.deviceStats()
# puts "stats: #{stats}\n\n"
#
# device = CommaAPI.device(id: "12345")
# puts "device: #{devices}\n"
#
# device = CommaAPI.deviceDefault()
# puts "device: #{device}\n\n"
