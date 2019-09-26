# temporary - in the final example use this as rubygem
# require_relative '../../api_client'
require_relative 'api_lib'

# with bundler
require 'bundler'
Bundler.require :default

# without bundler
# require "oj"
# require "roda"

CONFIG = {
  # host: "http://athena-dashboard.mkv.run". # remote
  host: ENV["CORS_HOST"] || "http://mkvmbp3.local" || "http://localhost", # docker
  # host: "http://localhost:3001". # local
}
