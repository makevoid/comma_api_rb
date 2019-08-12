require "net/https"
require 'json'
# require 'bundler'
# Bundler.require :default
require_relative 'config'

PATH = File.expand_path "./"

# -----
# TODO: refactor

module HTTP

  include Config

  def request(url:)
    uri  = URI url
    req  = Net::HTTP::Get.new uri.request_uri
    req["Authorization"] = "JWT #{JWT_TOKEN}"
    resp = http(uri: uri).request req
    JSON.parse resp.body
  end

  def http(uri:)
    http = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    http
  end

end
