require_relative '../lib/comma-api-rb'

puts "\nAPI.deviceDefault()\n---"
device = CommaAPI::API.deviceDefault()
device.delete "public_key"
puts "device: #{device}\n\n"
# lat - lng - speed - gps accuracy - gps timestamp - gps bearing
# (last_gps_lat - last_gps_lng - last_gps_speed - last_gps_accuracy - last_gps_time - last_gps_bearing)

puts "\nAPI.deviceDefaultStats()\n---"
stats = CommaAPI::API.deviceDefaultStats()
puts "device stats: #{stats}\n\n"
# distance, minutes, routes

puts "this one will take a while...\n\n"

puts "\nAPI.deviceDefaultLocation()\n---"
deviceLoc = CommaAPI::API.deviceDefaultLocation()
puts "device location: #{deviceLoc}\n\n"
# # lat lng time speed bearing
