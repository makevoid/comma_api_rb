# with bundler
require 'bundler'
Bundler.require :default

# without bundler
# require_relative "../../lib/comma-api-rb" # inside the repo, outside docker, or just `gem install comma-api-rb` in your terminal and then `require 'comma-api-rb'` in your program

route_id = ENV["ROUTE_ID"] # || "........" # put here your route id in case you want to hardcode it
ROUTE_ID = CGI.escape route_id


LOGS = ENV["LOGS"] == "1"
