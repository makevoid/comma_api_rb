require_relative '../lib/comma-api-rb'
Athena = CommaAPI::Athena

thermal = Athena.getMessage service: "thermal"
puts "thermal: #{thermal}\n\n"
