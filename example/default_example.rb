require_relative '../lib/comma-api-rb'

me = CommaAPI::API.me()
puts "me: #{me}\n\n"

exit

# ---

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
