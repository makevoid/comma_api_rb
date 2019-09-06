module Config

  API_HOST = "https://api.comma.ai"

  ::JWT_TOKEN = ENV["JWT_TOKEN"] || ENV["COMMA_JWT_TOKEN"]
  raise "JWT_TOKEN not defined, please pass it as ENV variable (rake JWT_TOKEN=YourJwtToken....)" unless JWT_TOKEN

  DONGLE_ID_DEFAULT = ENV["DONGLE_ID_DEFAULT"]


  # default device id - used on the `.deviceDefault()` methods

end


module ConfigAthena

  API_HOST = "https://athena.comma.ai"

  # ::JWT_TOKEN = Config::JWT_TOKEN
  DONGLE_ID_DEFAULT = Config::DONGLE_ID_DEFAULT

end
