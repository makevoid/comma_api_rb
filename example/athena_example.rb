# require 'comma-api-rb'

require_relative '../lib/comma-api-rb'

Athena = CommaAPI::Athena

carState = Athena.carState()
puts "carState: #{carState}\n\n"
