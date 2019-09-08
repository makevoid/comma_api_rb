require_relative '../../api_client'
require_relative 'api/env'


# # TODO:

# require 'bundler'
# Bundler.require :default


module FormatStream

  SSE_IDS = {}

  Format = -> (stream, hash) {
    out = ""
    id = SSE_IDS[:stream] || 0 # we need an auto-increment id for the sse to work
    # this is the (simple) output format - id: ID \n data: [JSON] \n\n
    out << "id: #{id}\n"
    out << "data: #{JSONDump.(hash)} \n\n" # json data
    SSE_IDS[:stream] = id
    out
  }

  # private

  JSONDump = -> (hash) {
    Oj.dump(hash, mode: :compat)
  }

end

Log = -> (msg) {
  puts msg
}

FetchLocation = -> {
  deviceLoc = CommaAPI.deviceDefaultLocation()
  Log.("location: #{deviceLoc}\n\n")
  deviceLoc
}

FetchStats = -> {
  stats = CommaAPI.deviceDefaultStats()
  Log.("stats: #{stats}\n\n")
  stats
}


CONFIG = {
  host: "http://localhost:3001"
}

class Api < Roda

  plugin :streaming

  DataTick = -> () {
    data = FetchStats.()
    puts "loc: #{data}"
    FormatStream::Format.(:update, data)
  }

  route do |r|

    r.root do
      "OK"
    end

    r.on "data" do
      response['Access-Control-Allow-Origin'] = CONFIG[:host]
      response['Content-Type'] = 'text/event-stream'

      stream do |out|
        while true do
          out << DataTick.()
          sleep 3
        end
      end
    end

  end

end
