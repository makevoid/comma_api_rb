require_relative 'env'

class CommaAPI

  extend Config
  extend HTTP

  class << self

    def me
      get "/me/"
    end

    def devices
      get "/me/devices/"
    end

    def device(id:)
      # TODO: complete device()
      get "/me/devices/"
    end

    def deviceDefault
      # TODO: complete deviceDefault()
      return device404Error unless DONGLE_ID_DEFAULT
      get "/me/devices/"
    end

    def deviceStats
      return device404Error unless DONGLE_ID_DEFAULT
      get "/devices/#{DONGLE_ID_DEFAULT}/stats#{args}"
    end

    def devicesStats(id:)
      devices = get "/devices"
      # TODO: loop through all devices, return all stats and a total
      devices.map { |device|

        get "/devices/#{device.f("dongle_id")}/stats#{args}"
      }
    end

    def deviceStatsId(id:)
      get "/devices/#{id}/stats#{args}"
    end

    def segments
      return device404Error unless DONGLE_ID_DEFAULT
      get "/devices/#{DONGLE_ID_DEFAULT}/segments#{args}"
    end

    def deviceSegments(id:)
      get "/devices/#{id}/segments#{args}"
    end

    def args
      defaultArgs # alias (alias :args :defaultArgs)
    end

    def defaultArgs
      one_week = 604800
      "?from=#{(Time.now - one_week - 1).to_i}"
    end

    # helper

    def get(method_name)
      # note: trailing slash gets added here
      puts "requesting: #{method_name}"
      url = "#{API_HOST}/v1#{method_name}"
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
