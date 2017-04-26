require 'fileutils'
require 'yaml'

module Rodot
  module Configuration
    # Default options.
    # All allowed keys should be list here.
    DEFAULT = {
      # Applications config files location
      'default_conf_dir_path' => File.expand_path('../../conf', File.dirname(__FILE__)),
      'default_app_db_dir'    => 'applications',

      # User configuration files location
      'conf_dir_path'         => '~/.rodot',
      'conf_file'             => 'conf.yml',
      'app_db_dir'            => 'applications',

      # Dotfiles storage location
      'storage_dir_path'      => '~/.dotfiles',
      'applications'          => [].freeze
    }.freeze

    # Override allowed keys
    OVERRIDE_ALLOWED_KEYS = [
      'storage_dir_path',
      'applications'
    ].freeze

    class << self
      # 1. load conf file
      # 2. merge default and user configuration
      # 3. merge overwrite
      def generate(override = {})
      end

      def default_conf_file
        @conf_file_path ||= File.expand_path(DEFAULT['conf_file'], DEFAULT['conf_dir_path'])
      end

      def load_user_conf
        file_path = conf_file_path
        if File.exist? file_path
          configuration = safe_load_file(file_path)
          check_user_configuration!(configuration, file_path)
          configuration
        else
          create_conf_file(file_path)
        end
      end

      private

      def safe_load_file(file_path)
        raise ArgumentError, "No parser for '#{file_path}' is available. Use a .y(a)ml file instead" unless File.extname(file_path) =~ /.ya?ml$/
        YAML.load_file(file_path) || {}
      end

      def check_config_is_hash!(configuration, file_path)
        raise ArgumentError, "Configuration file: (INVALID) #{file_path}" unless configuration.is_a?(Hash)
      end

      def create_conf_file(file_path)
        FileUtils.mkdir_p(File.dirname(file_path))

        default_configuration = OVERRIDE_ALLOWED_KEYS.reduce({}) do |conf, key|
          conf.merge!(key => DEFAULT[key])
        end

        File.open(file_path, 'w') do |f|
          f.write YAML.dump(default_configuration)
        end

        default_configuration
      end
    end
  end
end
