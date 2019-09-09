require_relative 'env'

require_relative 'athena_api'

require_relative 'comma_api'

if __FILE__ == $0 # $PROGRAM_FILE
  require_relative 'examples/default_example'
end
