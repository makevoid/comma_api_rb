require_relative '../lib/comma-api-rb'
Athena = CommaAPI::Athena

1.upto(20).each do
  msg = Athena.getMessage service: "logMessage"
  puts "log msg: #{msg.fetch :msg}\n\n"

  msg = Athena.getMessage service: "androidLog"
  puts "android: #{msg}\n\n"
end
