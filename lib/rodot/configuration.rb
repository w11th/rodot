require 'fileutils'
require 'yaml'

module Rodot
  class Configuration

    RODOT_HOME = File.expand_path('../..', File.dirname(__FILE__))
    DEFAULT_CONF_FILE = File.join(RODOT_HOME, 'config', 'default.yml')
    DEFAULT_APP_DB_DIR = File.join(RODOT_HOME, 'config', 'applications')

    USER_CONF_FILE = File.join(ENV['HOME'], '.rodot', 'conf.yml')
    USER_APP_DB_DIR = File.join(ENV['HOME'], '.rodot', 'applications')

    def initialize(base_hash = {}, override = {})
      @hash = {}
      @hash['@_default_conf_file'] = DEFAULT_CONF_FILE

      @hash['']

    end

    class << self
      # from Rubocop
      def load_file(path)
        path = File.absolute_path(File.expand_path(path))
        hash = load_yaml_file(path)
      end

      def load_yaml_file(absolute_path)
        yaml_code = IO.read(absolute_path, encoding: Encoding::UTF_8)
        hash = yaml_safa_load(yaml_code, absolute_path) || {}

        unless hash.is_a?(Hash)
          raise(TypeError, "Invalide configuration file: #{absolute_path}")
        end

        hash
      end

      def yaml_safe_load(yaml_code, file)
        if YAML.respond_to?(:safe_load)
          YAML.safe_load(yaml_code, [Regexp, Symbol], [], false, filename)
        else
          YAML.load(yaml_code, file)
        end
      end
    end
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
