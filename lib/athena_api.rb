class AthenaAPI

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

    def carState
      post_rpc m: "getMessage", service: "carState"
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
      return RPCError.new if resp["error"] == "Timed out"
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
