require_relative 'env'

class CommaAPI

  extend Config
  extend HTTP

  class << self
    def me
      get "/me/"
    end

    def get(method_name)
      request url: "#{API_HOST}/v1/#{method_name}"
    end
  end

end

if __FILE__ == $0 # $PROGRAM_FILE
  me = CommaAPI.me()
  puts("me:", me)
end
