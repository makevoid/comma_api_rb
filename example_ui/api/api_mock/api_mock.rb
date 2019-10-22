# creating this so I can develop the app offline (on a plane, long flight :/), also potentially useful for testing in the future

require_relative '../api_env'

DATA = eval File.read("./mocked_data.rb")

STATE = {
  counter: 0
}

CarStateMock = -> {
  STATE[:counter] += 1
  STATE[:counter] = 0  if STATE[:counter] >= DATA.size
  DATA[STATE[:counter]].fetch :carState
}

class ApiMock < Roda

  plugin :streaming

  DataTick = -> () {
    data = {
      carState: CarStateMock.(),
    }
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
          sleep 2
        end
      end
    end

  end

end

# unused, TODO: delete
# CarStateMockOld = -> {
#   {
#     wheelSpeeds: {
#       rl: 20 + rand(4),
#     },
#     steeringTorque: 1 + rand(3),
#     steeringAngle: 1 + rand(3),
#     brake: 0 + rand(1),
#   }
# }
