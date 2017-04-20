require 'yaml'
require 'fileutils'

module Rodot
  class Configuration < Hash
    BASE_DIR_PATH = File.expand_path('../..', File.dirname(__FILE__))
    DEFAULT_CONF_DIR_PATH = File.expand_path('config', BASE_DIR_PATH)
    DEFAULT_CONF_FILE_PATH = File.expand_path('conf.yml', DEFAULT_CONF_DIR_PATH)
    DEFAULT_APP_CONF_DIR_PATH = File.expand_path('applications', DEFAULT_CONF_DIR_PATH)

    class << self
      @default_configuration = nil

      def load_default
        @default_configuration ||= YAML.load_file(DEFAULT_CONF_FILE_PATH)
      end
    end

    def initialize

      # conf_file_path = File.expand_path(default_configuration["conf_file_name"], default_configuration["conf_dir_path"])

      # user_configuration = YAML.load_file(conf_file_path)

      # Utils.deep_merge_hashes(default_configuration, user_configuration)
      super
      default_configuration = Configuration.load_default
      merge!(default_configuration)
    end
  end
end
