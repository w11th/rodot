require 'rodot/version'
require 'rodot/configuration'
require 'rodot/cli'
require 'rodot/util'

module Rodot
  # Your code goes here...
  class << self
    def run(args)
      CLI.start(args)
    end

    def load_configuration(override = {})
    end
  end
end
