module Rodot
  class Application
    attr_accessor :name
    attr_accessor :dotfiles

    def initialize(name = nil, dotfiles = [])
      @name = name
      @dotfiles = dotfiles
    end

    def invalid?
      @name.nil? || @dotfiles.empty?
    end

    def to_hash
      { 'name' => @name, 'dotfiles' => @dotfiles }
    end
  end
end
