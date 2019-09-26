require_relative '../lib/comma-api-rb'

me = CommaAPI::API.me()
puts "me: #{me}\n\n"

exit

# ---

# device = CommaAPI::API.deviceDefault()
# puts "device: #{device}\n\n"

# lat - lng - speed - gps accuracy - gps timestamp - gps bearing
# last_gps_lat - last_gps_lng - last_gps_speed - last_gps_accuracy - last_gps_time - last_gps_bearing

# ---

deviceLoc = CommaAPI::API.deviceDefaultLocation()
puts "device location: #{deviceLoc}\n\n"
# # lat lng time speed bearing
# # note - takes long ? because device is offline?


# --------------------

# stats = CommaAPI::API.deviceDefaultStats()
# puts "device stats: #{stats}\n\n"
# distance, minutes, routes
# total stats: miles driven, minutes, number of sessions

# ---

# Athena Examples:

puts "\n\nAthena\n---\n"
# thermal = CommaAPI::Athena.thermal()
# puts "thermal: #{thermal}\n\n"
#
# health = CommaAPI::Athena.health()
# puts "health: #{health}\n\n"

androidLog = CommaAPI::Athena.logMessage()
puts "androidLog: #{androidLog}\n\n"

# gpsLocation = CommaAPI::Athena.gpsLocation()
# puts "gpsLocation: #{gpsLocation}\n\n"

# ---

# devices = CommaAPI::API.devices()
# puts "devices: #{devices}\n\n"

# segments = CommaAPI::API.segments()
# puts "segments: #{segments}\n\n"

# others to try:
#
# stats = CommaAPI::API.deviceStats()
# puts "stats: #{stats}\n\n"
#
# device = CommaAPI::API.device(id: "12345")
# puts "device: #{devices}\n"
#
# device = CommaAPI::API.deviceDefault()
# puts "device: #{device}\n\n"
