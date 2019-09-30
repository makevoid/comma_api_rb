require_relative '../lib/comma-api-rb'

ladder = CommaAPI::API.leaderboard()
ladder = ladder.f "weekly"
puts "weekly ladder:"
ladder.each_with_index do |user, idx|
  puts "#{"%02d" % (idx+1)}) #{user.f("username").ljust 20} (#{user.f "weekly"} points)"
end
