# require_relative '../../api_client'
require_relative 'api_env'

# unused

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

# we use Athena in this example (device)

FetchCarState = -> {
  carState = CommaAPI::Athena.carState()
  Log.("carState: #{carState}\n\n")
  carState
}

class Api < Roda

  plugin :streaming

  DataTick = -> () {
    data = {
      carState: FetchCarState.(),
    }
    puts "loc: #{data}"
    FormatStream::Format.(:update, data)
  }

  route do |r|

    r.root do
      # puts "Version: #{CommaAPI::VERSION}"
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
