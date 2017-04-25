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
      configuration = Configuration.new
    end
  end
end
