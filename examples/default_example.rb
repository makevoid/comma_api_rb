require_relative '../api_client'

me = CommaAPI.me()
puts "me: #{me}\n\n"

# ---

# device = CommaAPI.deviceDefault()
# puts "device: #{device}\n\n"

# lat - lng - speed - gps accuracy - gps timestamp - gps bearing
# last_gps_lat - last_gps_lng - last_gps_speed - last_gps_accuracy - last_gps_time - last_gps_bearing

# ---

# deviceLoc = CommaAPI.deviceDefaultLocation()
# puts "device location: #{deviceLoc}\n\n"
# # lat lng time speed bearing
# # note - takes long ? because device is offline?


stats = CommaAPI.deviceDefaultStats()
puts "device stats: #{stats}\n\n"
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
