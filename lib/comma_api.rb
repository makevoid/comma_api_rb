module CommaAPI
  class API

    extend Config
    extend HTTP

    class << self

      # user

      def me
        get "/v1/me/"
      end

      # devices

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

      # device permissions

      # TODO: finish device permissions

      def deviceGrantPermissions(id:, email:)
        args = {
          email: email
        }
        post "/v1/devices/#{id}/add_user", args
      end

      def deviceRevokePermissions(id:, email:)
        args = {
          email: email
        }
        post "/v1/devices/#{id}/del_user", args
      end

      # routes

      def route(route_name:)
        get "/v1/route/#{route_name}/"
      end

      def routeFiles(route_name:)
        get "/v1/route/#{route_name}/files"
      end

      # segments

      def segments
        return device404Error unless DONGLE_ID_DEFAULT
        get "/v1/devices/#{DONGLE_ID_DEFAULT}/segments#{args}"
      end

      def deviceSegments(id:)
        return device404Error unless DONGLE_ID_DEFAULT
        get "/v1/devices/#{id}/segments#{args}"
      end

      def deviceDefaultSegments
        return device404Error unless DONGLE_ID_DEFAULT
        deviceSegments id: DONGLE_ID_DEFAULT
      end

      # leaderboard

      def leaderboard
        get "/v2/leaderboard/"
      end

      # args

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

end
