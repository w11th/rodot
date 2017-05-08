module Rodot
  class Application
    def initialize(name, dotfiles = [], storage_dir)
      @name = name
      @storage_dir = File.join(storage_dir, @name)
      dotfiles
    end

    def to_hash
      { 'name' => @name, 'dotfiles' => @dotfiles }
    end
  end
end
