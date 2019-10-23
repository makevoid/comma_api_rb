module CommaAPI

  class Athena

    extend ConfigAthena
    extend HTTP

    RPC_TIMEOUT = 3000 # 3s timeout considering mobile networks and messages to be not critical (at least all the GET requests)

    STATE = {
      rpc_id: 0
    }

    RpcId = -> {
      STATE[:rpc_id] += 1
    }

    class << self

      def getMessage(service:)
        post_rpc m: "getMessage", service: service
      end

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
          params: { service: service, timeout: RPC_TIMEOUT },
          jsonrpc: "2.0",
          id: RpcId.(),
        }.str_keys.to_json
      end

      def post_rpc(m:, service:)
        puts "-> rpc message: m: #{m.inspect}, service: #{service.inspect}"
        url = "#{API_HOST}/#{DONGLE_ID_DEFAULT}"
        data = rpc_msg(m: m, service: service)
        begin
          resp = post_request url: url, data: data
        rescue err
          return RPCError.new "JSON Parse Error"
        end
        parse_rpc resp, service: service
      end

      def parse_rpc(resp, service:)
        if resp["error"] == "Timed out"
          puts "timeout"
          return RPCError.new
        end
        if resp["error"] && resp["error"]["message"] == "Server error"
          puts "rescued error - api error: #{resp["error"]["message"]}"
          return RPCError.new
        end
        result = resp.fetch "result"
        result = result[service] if result[service]
        result = result["androidLogEntry"] if service == "androidLog"
        # TODO: use inflecto gem to snakecase keys
        result = JSON.parse result if result.is_a? String # TODO: do this only for `logMessage` service
        result.sym_keys
      end

    end

  end

end
