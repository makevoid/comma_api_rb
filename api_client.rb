require_relative 'env'


class RPCError; end

class Athena

  extend ConfigAthena
  extend HTTP

  STATE = {
    rpc_id: 0
  }

  RpcId = -> {
    STATE[:rpc_id] += 1
  }


  class << self

    def health
      post_rpc m: "getMessage", service: "health"
    end

    def logMessage
      post_rpc m: "getMessage", service: "logMessage"
    end

    def androidLog
      post_rpc m: "getMessage", service: "androidLog"
    end

    def procLog
      post_rpc m: "getMessage", service: "procLog"
    end

    def gpsLocation
      post_rpc m: "getMessage", service: "gpsLocation"
    end

    def thermal
      data = post_rpc m: "getMessage", service: "thermal"
      data[:cpu] = thermal_cpu_avg(data: data)
      data
    end

    # ---

    def thermal_cpu_avg(data:)
      temps = [data.f(:cpu0), data.f(:cpu1), data.f(:cpu2), data.f(:cpu3)]
      (temps.reduce(:+).to_f / temps.size).round
    end

    # ---

    def rpc_msg(m:, service:)
      {
        method: m,
        params: { service: service, timeout: 3000 },
        jsonrpc: "2.0",
        id: RpcId.(),
      }.str_keys.to_json
    end

    def post_rpc(m:, service:)
      puts "-> rpc message: m: #{m.inspect}, service: #{service.inspect}"
      url = "#{API_HOST}/#{DONGLE_ID_DEFAULT}"
      data = rpc_msg(m: m, service: service)
      resp = post_request url: url, data: data
      parse_rpc resp, service: service
    end

    def parse_rpc(resp, service:)
      return RPCError.new if resp["error"] && resp["error"]["message"] == "Server error"
      result = resp.fetch "result"
      result = result[service] if result[service]
      result = result["androidLogEntry"] if service == "androidLog"
      # TODO: use inflecto gem to snakecase keys
      result = JSON.parse result if result.is_a? String # TODO: do this only for `logMessage` service
      result.sym_keys
    end

  end

end

class CommaAPI

  extend Config
  extend HTTP

  class << self

    def me
      get "/v1/me/"
    end

    def devices
      get "/v1/me/devices/"
    end

    def device(id:)
      get "/v1.1/devices/#{id}/"
    end

    def deviceLocation(id:)
      get "/v1/devices/#{id}/location"
    end

    def deviceDefaultLocation
      return device404Error unless DONGLE_ID_DEFAULT
      deviceLocation id: DONGLE_ID_DEFAULT
    end

    def deviceDefault
      return device404Error unless DONGLE_ID_DEFAULT
      device id: DONGLE_ID_DEFAULT
    end

    def deviceDefaultStats
      return device404Error unless DONGLE_ID_DEFAULT
      deviceStats id: DONGLE_ID_DEFAULT
    end

    def deviceStats(id:)
      get "/v1/devices/#{id}/stats"
    end

    def devicesStat(id:)
      devices = get "/v1/devices"
      # TODO: loop through all devices, return all stats and a total
      devices.map { |device|
        get "/v1/devices/#{device.f("dongle_id")}/stats#{args}"
      }
    end

    def deviceStatsId(id:)
      get "/v1/devices/#{id}/stats#{args}"
    end

    def segments
      return device404Error unless DONGLE_ID_DEFAULT
      get "/v1/devices/#{DONGLE_ID_DEFAULT}/segments#{args}"
    end

    def deviceSegments(id:)
      get "/v1/devices/#{id}/segments#{args}"
    end

    def args
      defaultArgs # alias (alias :args :defaultArgs)
    end

    def defaultArgs
      one_week = 604800
      "?from=#{(Time.now - one_week - 1).to_i}"
    end

    def opAuth
      "https://api.commadotai.com/v2/pilotauth/"
    end


    # helper

    def get(method_name)
      # note: trailing slash gets added here
      puts "requesting: #{method_name}"
      url = "#{API_HOST}#{method_name}"
      puts url
      request url: url
    end


    # errors

    def device404Error
      { error: 'Error: DONGLE_ID_DEFAULT is missing - this method cannot be executed, you need to specify a dongle id' }.to_json
    end

  end

end

if __FILE__ == $0 # $PROGRAM_FILE
  require_relative 'examples/default_example'
end
