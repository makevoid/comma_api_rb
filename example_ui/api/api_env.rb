# temporary - in the final example use this as rubygem
# require_relative '../../api_client'
require_relative 'api_lib'

# with bundler
require 'bundler'
Bundler.require :default

# without bundler
# require "oj"
# require "roda"

# DEFAULT_HOST = "http://localhost:3001"

# DEFAULT_HOST = "http://mkvd.local:3001"  # main
# DEFAULT_HOST = "http://mkvmbp3.local:3001" # laptop

DEFAULT_HOST = "http://mkvd.eu.ngrok.io" # remote1
# DEFAULT_HOST = "http://athena-dashboard.mkv.run" # remote2

CONFIG = {
  host: ENV["CORS_HOST"] || DEFAULT_HOST,
}
