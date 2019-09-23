# require_relative './lib/version'

module CommaAPI
  VERSION = "0.3.2"
end

Gem::Specification.new do |s|
  s.name        = "comma-api-rb"
  s.version     = CommaAPI::VERSION
  s.licenses    = ["GPL-3.0"]
  s.summary     = "Comma and Athena API ruby library (prototype)"
  s.description = "Comma and Athena API ruby library (prototype - this version is currently in WIP, public API and functionality is guaranteed to change overtime :D, thanks for understanding)"
  s.authors     = ["@makevoid - Francesco Canessa"]
  s.email       = "makevoid@gmail.com"
  s.files       = Dir.glob("./lib/*.rb")
  s.require_paths = ['lib']
  s.homepage    = "https://github.com/makevoid/comma_api_rb"
  s.metadata    = { "source_code_uri" => "https://github.com/makevoid/comma_api_rb" }
end
