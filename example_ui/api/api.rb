# require_relative '../../api_client'
require_relative 'api_env'

# we use Athena in this example (EON, the device), asking for the `carState` current service state returned as a "log" message 

FetchCarState = -> {
  carState = CommaAPI::Athena.carState() # returns a dictionary/hash
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

      stream do |out| # sse via roda "stream" are beautiful, there's no doubt <3
        while true do
          out << DataTick.() # calls the tick that triggers the Athena call via comma.ai's API
          sleep 3 # don't spam comma too much plz
        end
      end
    end

  end

end
