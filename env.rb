require "net/https"
require 'json'
# require 'bundler'
# Bundler.require :default
require_relative 'config'

PATH = File.expand_path "./"

# -----
# TODO: refactor

module HTTP

  def request(url:)
    uri  = URI url
    req  = Net::HTTP::Get.new uri.request_uri
    req["Authorization"] = "JWT #{::JWT_TOKEN}"
    resp = http(uri: uri).request req
    JSON.parse resp.body
  end

  def post_request(url:, data:)
    uri  = URI url
    req  = Net::HTTP::Post.new uri.request_uri
    req["Authorization"] = "JWT #{::JWT_TOKEN}"
    req.body = data
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


# TODO: move (and refactor with refinements)

module Monkeypatches
  class ::Hash
    alias :f :fetch

    def sym_keys
      Hash[self.map{ |key,value| [key.to_sym, value] }]
    end

    def str_keys
      Hash[self.map{ |key,value| [key.to_s, value] }]
    end
  end
end

include Monkeypatches
