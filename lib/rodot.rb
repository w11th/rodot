require 'rodot/version'
require 'rodot/configuration'
require 'rodot/cli'
require 'rodot/utils'

module Rodot
  # Your code goes here...
  class << self
    def run(args)
      CLI.start(args)
    end

    def configure(override = {})
      # 1. load user conf file
      # 2. override with options
      # return Configuration
    end
  end
end
