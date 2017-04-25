require 'yaml'

module Rodot
  class Configuration < Hash
    BASE_DIR_PATH = File.expand_path("../..", File.dirname(__FILE__))
    DEFAULT_CONF_DIR_PATH = File.expand_path("config", BASE_DIR_PATH)
    DEFAULT_CONF_FILE_PATH = File.expand_path("conf.yml", DEFAULT_CONF_DIR_PATH)
    DEFAULT_APP_DB_DIR_PATH = File.expand_path("applications", DEFAULT_CONF_DIR_PATH)

  end
end
