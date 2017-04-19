require 'rodot'
require 'thor'

module Rodot
  class CLI < Thor
    # class_option :verbose, type: :boolean

    # desc "hello NAME [FROM]", "say hello to NAME"
    # long_desc <<-LONGDESC
    #   `rodot hello` will print out a message to a person of your choosing.
    #   You can

    #   > $ rodot hello
    #   \x5> from: where
    # LONGDESC
    # option :from, required: true
    # option :yell, type: :boolean, desc: 'yell or not, true or false', banner: 'true or false', aliases: '-L'
    # def hello(name)
    #   puts '> saying hello' if options[:verbose]
    #   puts "from: #{options[:from]}" if options[:from]
    #   puts "#{'YELLED:' if options[:yell]}Hello #{name}"
    #   puts '> done saying hello' if options[:verbose]
    # end

    # desc "remote SUBCOMMAND ...ARGS", "mange set of tracked repositories"
    # subcommand "remote", Remote

    desc "list [applications]", "list applications"
    def list(*applications)
      puts applications.inspect
    end

    desc "version", "show version"
    def version
      puts "Rodot version: #{Rodot::VERSION}"
    end
  end
end
