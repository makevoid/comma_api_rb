require_relative '../api_client'

me = CommaAPI.me()
puts "me: #{me}\n"

devices = CommaAPI.devices()
puts "devices: #{devices}\n"

# device = CommaAPI.device(id: "12345")
# puts "device: #{devices}\n"

device = CommaAPI.deviceDefault()
puts "device: #{devices}\n"
