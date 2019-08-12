require_relative 'env'

class CommaAPI

  extend Config
  extend HTTP

  class << self

    def me
      get "/me"
    end

    def devices
      get "/me/devices"
    end

    def device(id:)
      get "/me/devices"
    end

    def deviceDefault
      return JSON.parse error: 'Error: DONGLE_ID_DEFAULT is missing - this method cannot be executed, you need to specify a dongle id'
      get "/me/devices"
    end


    # helper

    def get(method_name)
      # note: trailing slash gets added here
      request url: "#{API_HOST}/v1/#{method_name}/"
    end

  end

end

if __FILE__ == $0 # $PROGRAM_FILE
  require_relative 'examples/default_example'
end
