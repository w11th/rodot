require 'thor'

module Rodot
  class CLI < Thor
    desc "list", "list all available applications"
    def list
    end

    desc "status <application> [<applications>*]", "display the status of application"
    def status(application, *applications)
    end

    desc "add [applications]", "add applications to cnf.yml"
    def add(application, *applications)
    end

    desc "delete [application]", "delete applications from cnf.yml"
    def delete(application, *applications)
    end

    desc "store [application]", "store the application dotfiles and make symbol link"
    def store(application, *applications)
    end

    desc "restore [application]", "restore the application dotfiles and make symbol link"
    def restore(application, *applications)
    end

    desc "unlink [application]", "break the linked application dotfiles and restore them"
    def unlink(application, *applications)
    end

    desc "version", "show version"
    def version
      puts "Rodot version: #{Rodot::VERSION}"
    end
  end
end
