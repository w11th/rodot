module Rodot
  # Dotfile model.
  # Manage source dotfile and dest dotfile.
  class Dotfile
    attr_accessor :source
    attr_accessor :dest

    STATUS_ENUM = {
      no_source: "Source doesn't exist.",
      no_dest: "Dest doesn't exist.",
      no_both: "Either source & dest exists.",
      unlinked: "Both source & dest exist, but source doesn't symlink to dest.",
      linked: "Both source & dest exist, and source symlinked to desc."
    }.freeze

    def initialize(source, dest)
      @source = source
      @dest = dest
    end

    def source_exist?
      File.exist?(@source)
    end

    def dest_exist?
      File.exist?(@dest)
    end

    def source_symlink?
      File.symlink?(@source)
    end

    def linked?
      false unless source_exist? && dest_exist?
      false unless source_symlink?
      File.readlink(source) == @dest
    end

    def status
      source_exists = source_exist?
      desc_exists = dest_exist?

      if source_exists && desc_exists
      end
    end
  end
end
