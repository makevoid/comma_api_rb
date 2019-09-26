require "net/https"
require 'json'
require 'cgi'
# require 'bundler'
# Bundler.require :default
require_relative 'config'
require_relative 'errors'
require_relative 'version'

module CommaAPI
  PATH = File.expand_path "./"

  # -----
  # TODO: refactor

  require_relative 'api_client_lib'

  include Monkeypatches
end
