require_relative '../api_client'

me = CommaAPI.me()
puts "me: #{me}\n\n"

devices = CommaAPI.devices()
puts "devices: #{devices}\n\n"

segments = CommaAPI.segments()
puts "segments: #{segments}\n\n"


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
