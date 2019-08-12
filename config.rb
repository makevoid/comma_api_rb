module Config

  JWT_TOKEN = ENV["JWT_TOKEN"] || ENV["COMMA_JWT_TOKEN"]
  raise "JWT_TOKEN not defined, please pass it as ENV variable (rake JWT_TOKEN=YourJwtToken....)" unless JWT_TOKEN

  API_HOST = "https://api.comma.ai"

  # default device id - totally optional, just used on the `.deviceDefault()` method
  DONGLE_ID_DEFAULT = ENV["DONGLE_ID_DEFAULT"]
  DEVICE_ID_DEFAULT = DONGLE_ID_DEFAULT # alias, dongle is not cool, ding ding dong dongle lol - TODO: remove this comment :D

end
